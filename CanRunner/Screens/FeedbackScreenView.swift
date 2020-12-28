//
//  FeedbackScreenView.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/20/20.
//  Copyright © 2020 Bradley Kukuk. All rights reserved.
//

import SwiftUI

struct FeedbackScreenView: View {
    @State public var imagePickerOption = false;
    var body: some View {
        VStack(alignment: .center){
            Text("1690 W Historic Rte 66, Flagstaff, AZ 86001")
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
                .font(.title)
                .frame(width: 400, height: 100, alignment: .top)
                .foregroundColor(Color.black)
            
            Image("House")
                .frame(width: 300, height: 300, alignment: .top)
                .clipShape(Rectangle())
                .overlay(Rectangle().stroke(Color.white, lineWidth: 4))
                .shadow(radius: 10)
                .padding(.bottom, 5)
            
            Text("No Job, This is a gas station")
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
                .font(.title)
                .frame(width: 200, height: 100, alignment: .top)
                .foregroundColor(Color.red)
            
            Button("Continue and Finish") {
                self.imagePickerOption.toggle()
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 50)
            .background(Color.green)
            .cornerRadius(10)
            .padding(.top, 25)
            
            Button("Report Any Feedback")
            {
                print("Feedback")
            }
            .foregroundColor(.white)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 50)
            .background(Color.red)
            .cornerRadius(10)
            .padding(.top, 25)
        }.sheet(isPresented: self.$imagePickerOption, content: {
            ImagePicker()
        })
}

}

struct FeedbackScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackScreenView()
    }
}
