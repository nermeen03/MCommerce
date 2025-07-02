//
//  OnboardingView.swift
//  MCommerce
//
//  Created by abram on 02/07/2025.
//
import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                ForEach(0..<onboardingData.count, id: \.self) { index in
                    VStack(spacing: 30) {
                        Image(onboardingData[index].imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 400)

                        Text(onboardingData[index].title)
                            .font(.title)
                            .bold()

                        Text(onboardingData[index].description)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        if index == onboardingData.count - 1 {
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
                            }
                        }
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // 👈 hide default dots

            // ✅ Custom Page Dots
            HStack(spacing: 8) {
                ForEach(0..<onboardingData.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentPage ? Color.deepPurple : Color.gray.opacity(0.4))
                        .frame(width: 10, height: 10)
                }
            }
            .padding(.top, 16)
        }
    }
}

//import SwiftUI
//
//struct OnboardingView: View {
//    @State private var currentPage = 0
//    @AppStorage("hasSeenOnboarding") var hasSeenOnboarding: Bool = false
//    @EnvironmentObject var coordinator: AppCoordinator
//
//    var body: some View {
//        TabView(selection: $currentPage) {
//            ForEach(0..<onboardingData.count, id: \.self) { index in
//                VStack(spacing: 30) {
//                    Image(onboardingData[index].imageName)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 400)
//
//                    Text(onboardingData[index].title)
//                        .font(.title)
//                        .bold()
//
//                    Text(onboardingData[index].description)
//                        .font(.body)
//                        .multilineTextAlignment(.center)
//                        .padding(.horizontal)
//
//                    if index == onboardingData.count - 1 {
//                        Button(action: {
//                            hasSeenOnboarding = true
//                            coordinator.navigate(to: .welcome)
//                        }) {
//                            Text("Get Started")
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.deepPurple)
//                                .cornerRadius(12)
//                                .padding(.horizontal)
//                        }
//                    }
//                }
//                .tag(index)
//            }
//        }
//        .tabViewStyle(PageTabViewStyle())
//    }
//}

let onboardingData: [OnboardingPage] = [
    OnboardingPage(imageName: "onboard1", title: "Welcome", description: "Discover new features."),
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
