//
//  ContentView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 14/06/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var showAd = false
    @State private var adTimer: Timer?
    @State private var repeatAdTimer: Timer?

    var body: some View {
        ZStack {
            HomeView()
            if showAd {
                ProductAdView(onClose: hideAd)
                    .transition(.opacity)
                    .zIndex(1)
            }
        }
        .onAppear {
            scheduleNextAd()
        }
        .onDisappear {
            adTimer?.invalidate()
            repeatAdTimer?.invalidate()
        }
        .animation(.easeInOut, value: showAd)
    }

    private func scheduleNextAd() {
        repeatAdTimer?.invalidate()
        repeatAdTimer = Timer.scheduledTimer(withTimeInterval: 30, repeats: true) { _ in
            showAd = true
            startAdDismissTimer()
        }
    }

    private func startAdDismissTimer() {
        adTimer?.invalidate()
        adTimer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
            hideAd()
        }
    }

    private func hideAd() {
        adTimer?.invalidate()
        showAd = false
    }
}



#Preview {
    ContentView()
}

