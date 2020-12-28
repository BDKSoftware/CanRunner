//
//  MyAccountScreenView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/20/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct MyAccountScreenView: View {
    var ref = Database.database().reference()
    @State public var currentUser = Auth.auth().currentUser?.email
    @State public var userData = []
    @State public var userEmail = ""
    @State public var userPhone = ""
    @State public var address = ""
    @State public var city = ""
    @State public var state = ""
    @State public var password = ""
    
    func logout()
    {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    
    
    var body: some View {
        VStack(alignment: .center){
            Text("Your Account Information")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .padding(.top)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 400, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                .foregroundColor(Color.orange)
            List{
                HStack{
                    Text("Email")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text(self.userEmail)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
                
                HStack{
                    Text("Phone")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text(self.userPhone)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
                HStack{
                    Text("Address")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text(self.address)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
                HStack{
                    Text("City")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text(self.city)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
                HStack{
                    Text("State")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text(self.state)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
                HStack{
                    Text("Password")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text(self.password)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
                
            }
            HStack{
                NavigationLink(destination: LoginScreenView()) {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color.orange)
                .cornerRadius(10)
                .padding(.top, 25)
                .padding(.bottom, 25)
                
            }
            
        }// Vstack
        
        .onAppear(){
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let email = value?["email"] as? String ?? ""
                let phone = value?["phoneNumber"] as? String ?? ""
                let password = value?["password"] as? String ?? ""
                
                self.userEmail = email
                self.userPhone = phone
                self.password = password
            }) { (error) in
                print(error.localizedDescription)
            }
            self.ref.child("Users").child(userID!).child("AddressInfo").observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let address = value?["address"] as? String ?? ""
                let city = value?["city"] as? String ?? ""
                let state = value?["state"] as? String ?? ""
                
                
                self.address = address
                self.city = city
                self.state = state
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }//Body
}//View

struct MyAccountScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountScreenView()
    }
}
