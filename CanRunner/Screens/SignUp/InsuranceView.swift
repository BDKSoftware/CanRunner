//
//  InsuranceView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/23/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct InsuranceView: View {
    @State private var autoPolicyNumber = ""
    @State private var autoProvider = ""
    @State private var e_name = ""
    @State private var e_phone = ""
    @State private var e_relation = ""
    @State private var color = Color.black.opacity(0.7)
    @State private var ref = Database.database().reference()
    
    func uploadUserPersonalInfo(){
        let userID = Auth.auth().currentUser?.uid
        if(self.autoPolicyNumber != "" && self.autoProvider != "" && self.e_name != "" && self.e_phone != "" && self.e_relation != "")
        {
            self.ref.child("Users/").child(userID!).child("/InsuranceInfo/").setValue(["autoPolicyNumber": self.autoPolicyNumber, "autoProvider": self.autoProvider, "E_name": self.e_name, "e_phone": self.e_phone, "e_relation": self.e_relation])
        }
    }
    
    var body: some View {
        VStack{
            
            Text("Please Enter Insurance Information")
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .multilineTextAlignment(.center)
            .padding()
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            .frame(width: 400, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
            .foregroundColor(Color.orange)
            
            TextField("Auto Insurance Policy Provider", text: self.$autoProvider)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.autoProvider != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("Auto Insurance Policy Number", text: self.$autoPolicyNumber)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.autoPolicyNumber != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("Emergency Contact Name", text: self.$e_name)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.e_name != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("Emergency Contact Phone Number", text: self.$e_phone)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.e_phone != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            TextField("Emergency Contact Relation", text: self.$e_relation)
                .background(Color.white)
                .autocapitalization(.none)
                .padding()
                .background(RoundedRectangle(cornerRadius: 4).stroke(self.e_relation != "" ? Color(.orange) : self.color,lineWidth: 2))
                .padding(.top, 15)
                .padding(.horizontal)
            
            NavigationLink(destination: BankingInfoScreenView()){
                Text("Continue to Next Page")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }.simultaneousGesture(TapGesture().onEnded{
                self.uploadUserPersonalInfo()
            })
                
                .background(Color.orange)
                .cornerRadius(10)
                .padding(.top, 25)
            
            
        }
    }
}

struct InsuranceView_Previews: PreviewProvider {
    static var previews: some View {
        InsuranceView()
    }
}
