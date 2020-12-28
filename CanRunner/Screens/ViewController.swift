//
//  ViewController.swift
//  
//
//  Created by Bradley Kukuk on 8/23/20.
//

import UIKit
import MapboxDirections
import MapboxNavigation
import MapboxCoreNavigation
import Mapbox

class ViewController: UIViewController {
    
    var mapView: NavigationMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = NavigationMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(mapView)
    }
    
}
