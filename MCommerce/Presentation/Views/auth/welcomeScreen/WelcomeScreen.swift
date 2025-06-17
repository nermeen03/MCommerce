//
//  WelcomeScreen.swift
//  WelcomeScreenDemo
//
//  Created by Jailan Medhat on 16/06/2025.
//

import SwiftUI

struct WelcomeScreen: View {
    var body: some View {
        ZStack{
            Image("welcomeBg").resizable().scaledToFill().edgesIgnoringSafeArea(.all)
            VStack{ Spacer()
               
                CustomButton(text: "Login", textColor: .orangeCustom, backgroundColor: .white ,verticalOffset: -50, action: {})
                CustomButton(text: "Skip", textColor: .white, backgroundColor: .clear ,verticalOffset: -50, action: {})
            }
        }
    }
}

#Preview {
    WelcomeScreen()
}
extension Color {
    static let pinkPurple = Color(red: 206/255, green: 4/255, blue: 140/255) // #CE048C
    static let deepPurple = Color(red: 77/255, green: 10/255, blue: 142/255) // #4D0A8E
    static let orangeCustom = Color(red: 1.0, green: 85/255, blue: 0.0)
    static let pinkPurpleGradient = LinearGradient(
        gradient: Gradient(colors: [.pinkPurple, .deepPurple]),
        startPoint: .leading,
        endPoint: .trailing
    )
}
