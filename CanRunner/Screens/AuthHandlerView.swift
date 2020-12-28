//
//  AuthHandlerView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/23/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI

struct AuthHandlerView: View {
    @State var didSignUp = 0
    var body: some View {
        
        VStack {
            
        
        if(didSignUp == 0){
            SignUpScreenView()
        }
        
        if(didSignUp == 1){
            UserAddressSignUpView()
        }
        
        }// Vstack
    }// Body
}//View

struct AuthHandlerView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHandlerView()
    }
}
