//
//  OnboardingView.swift
//  MCommerce
//
//  Created by abram on 02/07/2025.
//
//import SwiftUI

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        ZStack {
            
            GeometryReader { geometry in
                TabView(selection: $currentPage) {
                    ForEach(0..<onboardingData.count, id: \.self) { index in
                        Image(onboardingData[index].imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .clipped()
                            .tag(index)
                            .ignoresSafeArea()
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .ignoresSafeArea()
            VStack {
                Spacer(minLength: 700)
                
                VStack(spacing: 20) {
                    Text(onboardingData[currentPage].title)
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                        .background(Color.deepPurple.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal)

                    Text(onboardingData[currentPage].description)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .background(Color.deepPurple.opacity(0.6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                
                HStack(spacing: 8) {
                    ForEach(0..<onboardingData.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentPage ? Color.deepPurple : Color.gray.opacity(0.4))
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.top, 16)

               
                if currentPage == onboardingData.count - 1 {
                    Button(action: {
                        hasSeenOnboarding = true
                        coordinator.navigate(to: .welcome)
                    }) {
                        Text("Get Started")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.deepPurple)
                            .cornerRadius(12)
                            .padding(.horizontal)
                            .padding(.top, 12)
                    }
                }

                Spacer(minLength: 40)
            }
            .padding()
        }
    }
}

let onboardingData: [OnboardingPage] = [
    OnboardingPage(imageName: "onboard1", title: "Welcome To Tradia", description: "Discover new features."),
    OnboardingPage(imageName: "onboard2", title: "Stay Connected", description: "Get updates instantly."),
    OnboardingPage(imageName: "onboard3", title: "Get Started", description: "Let's explore the app!")
]


#Preview {
    OnboardingView()
}

struct OnboardingPage: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
}
