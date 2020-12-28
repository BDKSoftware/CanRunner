//
//  RouteScreenView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/23/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI

struct RouteScreenView: View {
    @State public var showingModalView = true
    var body: some View {
        VStack{
            MapViewController()
        }
    }
}

struct RouteScreenView_Previews: PreviewProvider {
    static var previews: some View {
        RouteScreenView()
    }
}
