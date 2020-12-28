//
//  ContentView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/20/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    var body: some View {
        VStack{
            if status{
                HomeScreenView()
            }
            else{
                LoginScreenView()
            }
        }.animation(.spring())
            .onAppear {
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                    
                    let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    self.status = status
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


