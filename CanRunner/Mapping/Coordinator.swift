//
//  Coordinator.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/23/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import UIKit
import MapboxCoreNavigation
import Mapbox
import MapboxNavigation
import MapboxDirections

class Coordinator: NSObject, MGLMapViewDelegate {
    var control: MapView
    
    init(_ control: MapView) {
        self.control = control
    }
    
    
}
