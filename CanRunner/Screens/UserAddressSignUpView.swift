//
//  UserAddressSignUpView.swift
//  
//
//  Created by Bradley Kukuk on 8/23/20.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct UserAddressSignUpView: View {
    @State private var address = ""
    @State private var apt_suite = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipCode = ""
    @State private var color = Color.black.opacity(0.7)
    @State private var ref = Database.database().reference()
    
    func uploadUserAddressInfo(){
        let userID = Auth.auth().currentUser?.uid
        
        if(self.address != "" && self.apt_suite != "" && self.city != "" && self.state != "" && self.zipCode != "")
        {
            self.ref.child("Users/").child(userID!).child("/AddressInfo/").setValue(["address": self.address, "apt_suite": self.apt_suite, "city": self.city, "state": self.state, "zipCode": self.zipCode])
        }
        
    }
    
    var body: some View {
        VStack{
            
            Text("Please Enter Your Address Information")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .padding()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 400, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                .foregroundColor(Color.orange)
            TextField("Address", text: self.$address)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.address != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("Apt/Suite/Lot", text: self.$apt_suite)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.apt_suite != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("City", text: self.$city)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.city != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("State", text: self.$state)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.state != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("Zip Code", text: self.$zipCode)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.zipCode != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            NavigationLink(destination: PersonalInfoView()){
                Text("Continue to Next Page")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }.simultaneousGesture(TapGesture().onEnded{
                self.uploadUserAddressInfo()
            })
                
                .background(Color.orange)
                .cornerRadius(10)
                .padding(.top, 25)
            
            
        } // HStack
    } //Body
} // View

struct UserAddressSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        UserAddressSignUpView()
    }
}
