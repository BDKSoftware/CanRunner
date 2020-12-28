//
//  HomeScreenView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/20/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct HomeScreenView: View {
    @State private var ref = Database.database().reference()
    @State public var name = ""
    @State public var compled = 0
    
    var body: some View {
        TabView{
            
            MapViewController()
                .tabItem {
                    Image(systemName: "location.circle.fill")
                    Text("My Route")
                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            RouteInfoView()
                .tabItem {
                    Image(systemName: "list.dash")
                    Text("Route Info")
                }
                
            
            EarningScreenView()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Earnings")
                }
                
            
            FeedbackScreenView()
                .tabItem {
                    Image(systemName: "message")
                    Text("Feedback")
                }
                
            
            MyAccountScreenView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("My Account")
                }
                
            
        } // Tab View
    } // Some view
    
    struct HomeScreenView_Previews: PreviewProvider {
        static var previews: some View {
            HomeScreenView()
        }
    }

}
