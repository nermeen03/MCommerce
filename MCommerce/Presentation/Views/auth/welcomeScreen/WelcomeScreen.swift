//
//  WelcomeScreen.swift
//  WelcomeScreenDemo
//
//  Created by Jailan Medhat on 16/06/2025.
//

import SwiftUI

struct WelcomeScreen: View {
    @State private var goToLogin = false
    @State private var goToRegister = false
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
            ZStack {
                Image("welcomeBg")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    Spacer()

//                    NavigationLink(destination: Login(), isActive: $goToLogin) { EmptyView() }
//                    NavigationLink(destination: Register(), isActive: $goToRegister) { EmptyView() }

                    CustomButton(
                        text: "Login",
                        textColor: .orangeCustom,
                        backgroundColor: .white,
                        verticalOffset: -20,
                        action: {
                            coordinator.navigate(to: .login)
                        }
                    )

                    CustomButton(
                        text: "Register",
                        textColor: .orangeCustom,
                        backgroundColor: .white,
                        verticalOffset: -20,
                        action: {
                            coordinator.navigate(to: .signup)
                        }
                    )

                    CustomButton(
                        text: "Skip",
                        textColor: .white,
                        backgroundColor: .clear,
                        verticalOffset: -20,
                        action: {
                            coordinator.navigate(to: .home)
                        }
                    )
                }
            }
            .navigationBarHidden(true)
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
