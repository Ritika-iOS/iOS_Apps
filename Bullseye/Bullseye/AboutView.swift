//
//  AboutView.swift
//  Bullseye
//
//  Created by Mac_Admin on 16/11/20.
//

import SwiftUI

struct AboutView: View {
    let beige = Color(red: 255.0/255.0, green: 214.0/255.0, blue: 179.0/255.0)
    struct HeadingStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", fixedSize: 30))
                .padding(.bottom,20).padding(.top,20)
        }
    }
    struct TextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", fixedSize: 20))
                .padding(.bottom,20).padding(.leading,60).padding(.trailing,60)
        }
    }
    var body: some View {
        Group {
        VStack {
            Text("🎯BullsEye🎯").modifier(HeadingStyle())
            Text("This is BullsEye game where you need to aim for a praticular target").modifier(TextStyle())
            Text("Your goal is to place the slider as close as possible to the target value.The closer you hit the target,the better you score").modifier(TextStyle()).lineLimit(2)
            Text("Enjoy!!").modifier(TextStyle())
        }.navigationBarTitle("About BullsEye").background(beige)
        }.background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView().previewLayout(.fixed(width: 896, height: 414))
    }
}
