//
//  SpecialButton.swift
//  CanRunner
//
//  Created by Bradley Kukuk on 8/20/20.
//

import SwiftUI

struct SpecialButton: View {
    
    var buttonText = "";
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: 150, height: 50)
                .foregroundColor(.init("ButtonGray"))
                .border(Color.orange, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                
            
            Text(buttonText).bold()
                .foregroundColor(.orange)
            
            LeftCorner()
                .trim(from: 0.41, to: 0.59)
                .fill(Color.orange)
                .frame(width: 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct LeftCorner: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addRoundedRect(in: rect, cornerSize: CGSize(width: 5, height: 5))
        return path
    }
}

struct SpecialButton_Previews: PreviewProvider {
    static var previews: some View {
        SpecialButton()
    }
}

