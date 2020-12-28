//
//  EarningScreenView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/20/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase

struct EarningScreenView: View {
    @State private var ref = Database.database().reference()
    @State private var allTime = "0.00"
    @State private var weekly = "0.00"
    @State private var yearly = "0.00"
    @State private var monthly = "0.00"
    @State private var last = "0.00"
    
    var body: some View {
        VStack{
            Text("Your Earnings")
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .padding()
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .frame(width: 400, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                .foregroundColor(Color.orange)
            List{
                HStack{
                    Text("Your Last Route Earings:")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text("$" + self.last)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
                HStack{
                    Text("Your Weekly Route Earings:")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text("$" + self.weekly)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
                HStack{
                    Text("Your Last Month Route Earings:")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text("$" + self.monthly)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
                
                HStack{
                    Text("Your Yearly Route Earings:")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text("$" + self.yearly)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
                
                HStack{
                    Text("Your Career Route Earings:")
                        .multilineTextAlignment(.leading)
                        .font(.title)
                    Spacer()
                    Text("$" + self.allTime)
                        .multilineTextAlignment(.trailing)
                        .padding(.leading)
                        .foregroundColor(Color.orange)
                }
            }
            
            
        }.onAppear(){
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                let value = snapshot.value as? NSDictionary
                let allTimeEarnings = value?["allTimeEarnings"] as? String ?? ""
                let weeklyEarning = value?["weeklyEarning"] as? String ?? ""
                let yearlyEarning = value?["yearlyEarning"] as? String ?? ""
                let monthlyEarning = value?["monthlyEarnings"] as? String ?? ""
                let lastEarning = value?["lastEarnings"] as? String ?? ""
                
                self.allTime = allTimeEarnings
                self.weekly = weeklyEarning
                self.yearly = yearlyEarning
                self.monthly = monthlyEarning
                self.last = lastEarning
                
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }
        }// VStack
    }// Body View
} //  view

struct EarningScreenView_Previews: PreviewProvider {
    static var previews: some View {
        EarningScreenView()
    }
}
