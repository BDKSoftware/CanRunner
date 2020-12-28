//
//  MapViewController.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/23/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//
import SwiftUI

struct MapViewController: UIViewControllerRepresentable{
    
//    class Coordinator: NSObject, MapViewControllerDelegate, UINavigationController{
//
//    }
    
    func makeCoordinator() -> Coordinator {
        //Coordinator()
    }
    
    func updateUIViewController(_ uiViewController: MapView, context: Context) {
        
    }
    
    func makeUIViewController(context: Context) -> MapView {
        let map = MapView()
        
        //map.delegate = context.coordinator
        return map
    }
    
}
