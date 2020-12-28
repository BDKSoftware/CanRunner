//
//  PersonalInfoView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/23/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct PersonalInfoView: View {
    @State private var DOB = ""
    @State private var SSN = ""
    @State private var stateDate = ""
    @State private var carMake = ""
    @State private var carModel = ""
    @State private var carYear = ""
    @State private var carMilage = ""
    @State private var color = Color.black.opacity(0.7)
    @State private var ref = Database.database().reference()
    
    func uploadUserPersonalInfo(){
        let userID = Auth.auth().currentUser?.uid
        
        if(self.DOB != "" && self.SSN != "" && self.stateDate != "" && self.carMake != "" && self.carModel != "" && self.carYear != "" && self.carMilage != "")
        {
            self.ref.child("Users/").child(userID!).child("/PersonalInfo/").setValue(["DOB": self.DOB, "SSN": self.SSN, "startDate": self.stateDate, "carMake": self.carMake, "carModel": self.carModel, "carYear": self.carYear, "carMilage": self.carMilage])
        }
    }
    
    var body: some View {
        ScrollView(.vertical){
            VStack(alignment: .center){
                Text("Please Enter Additional Personal Infomation")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .padding()
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .frame(width: 400, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                    .foregroundColor(Color.orange)
                TextField("Date of Birth", text: self.$DOB)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.DOB != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                TextField("Social Security Number (Include Slashes)", text: self.$SSN)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.SSN != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                TextField("Prefered State Date (MM/DD/YYYY)", text: self.$stateDate)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.stateDate != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                TextField("Car Make", text: self.$carMake)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.carMake != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                TextField("Car Model", text: self.$carModel)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.carModel != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                TextField("Car Year", text: self.$carYear)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.carYear != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                TextField("Car Current Milage", text: self.$carMilage)
                    .background(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 4).stroke(self.carMilage != "" ? Color(.orange) : self.color,lineWidth: 2))
                    .padding(.top, 15)
                    .padding(.horizontal)
                
                NavigationLink(destination: InsuranceView()){
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
                
                
            }// VStack
        } // Scroll View
    } // Body
} // View

struct PersonalInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInfoView()
    }
}
