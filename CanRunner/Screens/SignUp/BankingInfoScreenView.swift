//
//  BankingInfoScreenView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/23/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI
import FirebaseDatabase
import FirebaseAuth

struct BankingInfoScreenView: View {
    @State private var bankNameOnAccount = ""
    @State private var nameOfBank = ""
    @State private var routingNumber = ""
    @State private var accountNumber = ""
    @State private var color = Color.black.opacity(0.7)
    @State private var ref = Database.database().reference()
    func uploadBankingInfo(){
        let userID = Auth.auth().currentUser?.uid
        if(self.bankNameOnAccount != "" && self.nameOfBank != "" && self.routingNumber != "" && self.accountNumber != "")
        {
            self.ref.child("Users/").child(userID!).child("/BankingInfo/").setValue(["nameOnAccount": self.bankNameOnAccount, "nameOfBank": self.nameOfBank, "routingNumber": self.routingNumber, "accountNumber": self.accountNumber])
        }
    }
    
    var body: some View {
        ScrollView(.vertical){
            VStack{
                Text("Please Enter Your Banking Information")
                TextField("Name On Account", text: self.$bankNameOnAccount)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.bankNameOnAccount != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                TextField("Name of Bank", text: self.$nameOfBank)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.nameOfBank != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                TextField("Routing Number", text: self.$routingNumber)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.routingNumber != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                TextField("Account Number", text: self.$accountNumber)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.accountNumber != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                NavigationLink(destination: LoginScreenView()){
                    Text("Continue and Login")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }.simultaneousGesture(TapGesture().onEnded{
                    self.uploadBankingInfo()
                })
                    
                    .background(Color.orange)
                    .cornerRadius(10)
                    .padding(.top, 25)
            }// VSTACK
        }// SCROLL VIEW
    } // BODY
} // VIEW

struct BankingInfoScreenView_Previews: PreviewProvider {
    static var previews: some View {
        BankingInfoScreenView()
    }
}
