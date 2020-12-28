//
//  LoginScreenView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/20/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct LoginScreenView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State var msg = ""
    @State var alert = false
    @State var color = Color.black.opacity(0.7)
    
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack(alignment: .center) {
                    Text("Welcome to CanRunner")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .padding()
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .frame(width: 400, height: 50, alignment: .top)
                        .foregroundColor(Color.orange)
                    
                    
                    Image("CanRunnerLogo1")
                        .frame(width: 300, height: 300, alignment: .top)
                        .background(Color.orange)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .padding(.bottom, 5)
                    
                    TextField("Email", text: self.$email)
                        .background(Color.white)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color(.orange) : self.color,lineWidth: 2))
                        .padding(.top, 15)
                        .padding(.horizontal)
                    
                    SecureField("Password", text: self.$password)
                        .background(Color.white)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.password != "" ? Color(.orange) : self.color,lineWidth: 2))
                        .padding(.top, 12)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                    
                    
                    
                    
                    HStack {
                        SpecialButton(buttonText: "Login").onTapGesture {
                            Auth.auth().signIn(withEmail:  self.email, password: self.password) { (verified, status) in
                                
                                if !(verified != nil){
                                    
                                    self.msg = "An Error Has Occured"
                                    self.alert.toggle()
                                }
                                else{
                                    
                                    UserDefaults.standard.set(true, forKey: "status")
                                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                }
                            }
                        }
                        
                        
                        NavigationLink(destination: SignUpScreenView()){
                            SpecialButton(buttonText: "Sign Up");
                        }
                        
                        
                    }.sheet(isPresented: self.$alert){
                        Text("Failed Login, Swipe Down to Return to Login").foregroundColor(.red)
                    }
                    
                }
                .navigationBarTitle("Login", displayMode: .inline)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
            .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
