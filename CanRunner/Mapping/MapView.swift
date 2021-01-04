// #-code-snippet: navigation dependencies-swift
import Mapbox
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import Firebase
import FirebaseDatabase
import FirebaseAuth
import Foundation
import UIKit
// #-end-code-snippet: navigation dependencies-swift
class MapView: UIViewController, MGLMapViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // #-code-snippet: navigation vc-variables-swift
    var mapView: NavigationMapView!
    var routeOptions: NavigationRouteOptions?
    var route: Route?
    var navigationButton: UIButton!
    var infoButton: UIButton!
    var infoView: UIView!
    var ref = Database.database().reference()
    var waypoints = [Waypoint]()
    var stops = [NSDictionary]()
    var orgin: CLLocationCoordinate2D!
    var userID = Auth.auth().currentUser?.uid
    
    
    
    
    // #-end-code-snippet: navigation vc-variables-swift
    // #-code-snippet: navigation view-did-load-swift
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = NavigationMapView(frame: view.bounds)
        
        
        view.addSubview(mapView)
        addButton()
        getUserInfo()
        //addInfoButton()
        getRoutes()
        
        // Set the map view's delegate
        mapView.delegate = self
        
        // Allow the map to display the user's location
        mapView.showsUserLocation = true
        mapView.setUserTrackingMode(.follow, animated: true, completionHandler: nil)
        
    }
    
    func addButton(){
        navigationButton = UIButton(frame: CGRect(x: (view.frame.width/2) - 100, y: view.frame.height - 150, width: 200, height: 50))
        navigationButton.backgroundColor = #colorLiteral(red: 1, green: 0.6416304708, blue: 0.03941884264, alpha: 1)
        navigationButton.setTitle("Start Your Route", for: .normal)
        navigationButton.setTitleColor(.white, for: .normal)
        navigationButton.layer.cornerRadius = 10
        navigationButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        navigationButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationButton.layer.shadowRadius = 5
        navigationButton.layer.shadowOpacity = 0.3
        navigationButton.addTarget(self, action: #selector(navigationButtonWasPressed(_:)), for: .touchUpInside)
        view.addSubview(navigationButton)
    }
    
    
    
    
    @objc func navigationButtonWasPressed(_ sender: UIButton){
        if let origin = mapView.userLocation?.coordinate {
            // Calculate the route from the user's location to the set destination
            calculateRoute(from: origin, to: self.waypoints[0].coordinate)
        } else {
            print("Failed to get user location, make sure to allow location access for this application.")
        }
    }
    
    
    // #-end-code-snippet: navigation view-did-load-swift
    // #-code-snippet: navigation long-press-swift
    // #-end-code-snippet: navigation long-press-swift
    // #-code-snippet: navigation calculate-route-swift
    // Calculate route to be used for navigation
    func calculateRoute(from origin: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        // Coordinate accuracy is how close the route must come to the waypoint in order to be considered viable. It is measured in meters. A negative value indicates that the route is viable regardless of how far the route is from the waypoint.
        let origin = Waypoint(coordinate: origin, coordinateAccuracy: -1, name: "Start")
        let destination = Waypoint(coordinate: destination, coordinateAccuracy: -1, name: "Finish")
        self.waypoints.insert(origin, at: 0)
        self.waypoints.insert(destination, at: self.waypoints.count)
        
        // Specify that the route is intended for automobiles avoiding traffic
        let routeOptions = NavigationRouteOptions(waypoints: self.waypoints, profileIdentifier: .automobile)
        
        // Generate the route object and draw it on the map
        Directions.shared.calculate(routeOptions) { [weak self] (session, result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let response):
                guard let route = response.routes?.first, let strongSelf = self else {
                    return
                }
                
                strongSelf.route = route
                strongSelf.routeOptions = routeOptions
                
                // Draw the route on the map after creating it
                strongSelf.drawRoute(route: route)
                
                // Show destination waypoint on the map
                strongSelf.mapView.showWaypoints(on: route)
                
                // Display callout view on destination annotation
                if let annotation = strongSelf.mapView.annotations?.first as? MGLPointAnnotation {
                    annotation.title = "Start navigation"
                    strongSelf.mapView.selectAnnotation(annotation, animated: true, completionHandler: nil)
                }
            }
        }
    }
    // #-end-code-snippet: navigation calculate-route-swift
    // #-code-snippet: navigation draw-route-swift
    func drawRoute(route: Route) {
        guard let routeShape = route.shape, routeShape.coordinates.count > 0 else { return }
        // Convert the route’s coordinates into a polyline
        var routeCoordinates = routeShape.coordinates
        let polyline = MGLPolylineFeature(coordinates: &routeCoordinates, count: UInt(routeCoordinates.count))
        
        // If there's already a route line on the map, reset its shape to the new route
        if let source = mapView.style?.source(withIdentifier: "route-source") as? MGLShapeSource {
            source.shape = polyline
        } else {
            let source = MGLShapeSource(identifier: "route-source", features: [polyline], options: nil)
            
            // Customize the route line color and width
            let lineStyle = MGLLineStyleLayer(identifier: "route-style", source: source)
            lineStyle.lineColor = NSExpression(forConstantValue: #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))
            lineStyle.lineWidth = NSExpression(forConstantValue: 4)
            
            // Add the source and style layer of the route line to the map
            mapView.style?.addSource(source)
            mapView.style?.addLayer(lineStyle)
        }
    }
    // #-end-code-snippet: navigation draw-route-swift
    // #-code-snippet: navigation callout-functions-swift
    // Implement the delegate method that allows annotations to show callouts when tapped
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    // Present the navigation view controller when the callout is selected
    func mapView(_ mapView: MGLMapView, tapOnCalloutFor annotation: MGLAnnotation) {
        guard let route = route, let routeOptions = routeOptions else {
            return
        }
        let navigationViewController = NavigationViewController(for: route, routeOptions: routeOptions)
        navigationViewController.modalPresentationStyle = .fullScreen
        self.present(navigationViewController, animated: true, completion: nil)
    }
    // #-end-code-snippet: navigation callout-functions-swift
    func getRoutes(){
        ref.child("Routes").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            //let value = snapshot.value as? NSDictionary
            var i = 0
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                guard let restDict = rest.value as? [String: Any] else { continue }
                let latitude = restDict["latitude"] as! CLLocationDegrees
                let longitude = restDict["longitude"] as! CLLocationDegrees
                //let note = restDict["note"] as! String
                let address = restDict["address"] as! String
                //                if(restDict["latitude"] == nil  || restDict["longitude"] == nil){
                //                    return
                //                }
                let completed = restDict["completed"] as! String
                let routeAssignment = restDict["routeAssignment"] as! String
                let temp = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                
                if(i == 0){
                    self.orgin = temp
                }
                
                //print("routeAssignment:  " + routeAssignment + "\n\n")
                //print("self.userRouteAssignment: " + self.userRoute  + "\n\n")
                
                if(completed == "N")
                {
                    let temp2 = Waypoint(coordinate: temp, coordinateAccuracy: -1, name: address)
                    self.waypoints.append(temp2)
                    self.stops.append(restDict as NSDictionary)
                    //print(self.stops)
                }
                
                i = i + 1
                
                
            }
            //print(self.waypoints)
            //print(self.stops)
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getUserInfo()
    {
        self.ref.child("Users").child(self.userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let userAssignedRoute = value?["routeAssignment"] as? String ?? ""
            
            var i = 0
            while(i < self.waypoints.count)
            {
                if(self.stops[i].value(forKey: "routeAssignment") as! String != userAssignedRoute)
                {
                    if(self.waypoints[i].name == (self.stops[i].value(forKey: "address") as! String))
                    {
                        self.waypoints.remove(at: i)
                        
                        
                    }
                }
                
                i = i + 1
            }
            
        }) { (error) in
            print(error.localizedDescription)
            
        }
        
    }
}
