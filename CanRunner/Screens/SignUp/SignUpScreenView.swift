//
//  SignUpScreenView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/20/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct SignUpScreenView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var phoneNumber = ""
    @State private var fullName = ""
    @State private var color = Color.black.opacity(0.7)
    @State private var ref = Database.database().reference()
    @State private var errorCode = "Please fill in the information needed below!"
    @State private var errorColor = Color.orange
    
    func uploadUserData(){
        Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
            if(error != nil){
                self.errorCode = error!.localizedDescription
                self.errorColor = Color.red
            }else{
                Auth.auth().signIn(withEmail: self.email, password: self.password)
                let userID = Auth.auth().currentUser?.uid
                self.ref.child("Users/").child(userID!).setValue(["username": self.fullName, "email": self.email, "phoneNumber": self.phoneNumber, "routeAssignment": "", "weeklyEarning":"0.00", "yearlyEarning":"0.00", "allTimeEarnings":"0.00", "monthlyEarnings":"0.00","lastEarnings": "0.00", "password": self.password ])
                print(Auth.auth().currentUser?.uid as Any)
            }
            
            
        }
    }
    
    var body: some View {
        VStack(alignment: .center){
            Text(self.errorCode)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .padding()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 400, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                .foregroundColor(self.errorColor)
            
            TextField("Full Name", text: self.$fullName)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.fullName != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("Email", text: self.$email)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("Phone Number", text: self.$phoneNumber)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.phoneNumber != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("Password", text: self.$password)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            NavigationLink(destination: UserAddressSignUpView()){
                Text("Continue to Next Page")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }.simultaneousGesture(TapGesture().onEnded{
                self.uploadUserData()
            })
                
                .background(Color.orange)
                .cornerRadius(10)
                .padding(.top, 25)
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct SignUpScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpScreenView()
    }
}
