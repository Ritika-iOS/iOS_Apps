//
//  ContentView.swift
//  Bullseye
//
//  Created by Mac_Admin on 25/10/20.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible = false
    @State var sliderValue = 30.0
    @State var target = Int.random(in: 1...100)
    @State var totalScore = 0
    @State var currentRound = 1
    struct LabelStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.white)
                .font(.custom("American Typewriter", size: 18)).modifier(shadowStyle())
        }
    }
    struct valueStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.yellow)
                .font(.custom("Arial Rounded MT Bold", size: 24)).modifier(shadowStyle())
        }
    }
    struct shadowStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/, radius: 5, x: 2, y: 2)
        }
    }
    struct ButtonLargeTextStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    struct ButtonSmallTextStyle : ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    var body: some View {
        
        VStack {
            VStack {
                ///Target Row
                
                
                ///Slider Row
                
                ///Hit me Button
                Spacer()
                HStack {
                    Text("Put the Bulls Eye as close as you can to:").modifier(LabelStyle())
                        
                    Text("\(target)").modifier(valueStyle())
                }
                Spacer()
               
                HStack{
                    Text("1").modifier(LabelStyle())
                    Slider(value: $sliderValue, in: 1...100).accentColor(.green)
                    Text("100").modifier(LabelStyle())
                }
                Spacer()
                Button(action: {
                    self.alertIsVisible = true
                    print("1")
                    
                }) {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Hit me!").modifier(ButtonLargeTextStyle())
                        /*@END_MENU_TOKEN@*/
                }.alert(isPresented: $alertIsVisible, content: {
                    () -> Alert in
                    print("2")
                    return Alert(title: Text(getAlertTitle()), message: Text("The slider value is: \(getRoundedValue())\n" + ("The score is \(pointsForCurrentRound())")), dismissButton: .default(Text("Awesome!!")){
                        self.totalScore += self.pointsForCurrentRound()
                        self.currentRound += 1
                        self.target = Int.random(in: 1...100)
                    })
                }).background(Image("Button")).modifier(shadowStyle())
                Spacer()
                /// Score Row
                HStack {
                    Button(action: {
                        resetGame()
                    }, label: {
                        HStack {
                        Image("StartOverIcon")
                        Text("Start Over").modifier(ButtonSmallTextStyle())
                        }}).background(Image("Button")).modifier(shadowStyle())
                    Spacer()
                    Text("Score:").modifier(LabelStyle())
                    Text("\(self.totalScore)").modifier(valueStyle())
                    Spacer()
                    Text("Round:").modifier(LabelStyle())
                    Text("\(self.currentRound)").modifier(valueStyle())
                    Spacer()
                    NavigationLink(destination: AboutView()){
                        HStack {
                        Image("InfoIcon")
                        Text("Info").modifier(ButtonSmallTextStyle())
                        }
                    }.background(Image("Button")).modifier(shadowStyle())
                }.padding(.bottom,20)
            }
             
        }.background(Image("Background"), alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).accentColor(.blue).navigationBarTitle("BullsEye")
        
    }
    func resetGame() {
        self.totalScore = 0
        self.currentRound = 1
        self.sliderValue = 30
    }
    func roundOff() -> Int {
        abs(target - getRoundedValue())
    }
    func getRoundedValue() -> Int {
        Int(sliderValue.rounded())
    }
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let bonus: Int
        let difference = roundOff()
        if difference == 0 {
           bonus = 100
        } else if difference == 1 {
           bonus = 50
        }
        else {
            bonus = 0
        }
        return maximumScore - difference + bonus
    }
    func getAlertTitle() -> String {
        let difference = roundOff()
        let alertTitle: String
        if difference == 0 {
            alertTitle = "Great Job"
        } else if difference < 5 {
            alertTitle = "You almost had it"
        } else if difference <= 10 {
            alertTitle = "Not Bad"
        } else {
            alertTitle = "Are you even trying"
        }
        return alertTitle
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
