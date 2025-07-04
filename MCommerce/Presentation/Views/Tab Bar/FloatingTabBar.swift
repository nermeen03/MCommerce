//
//  FloatingTabBar.swift
//  MCommerce
//
//  Created by abram on 16/06/2025.
//

import SwiftUI

import SwiftUI

enum Tab: String, CaseIterable {
    case home = "house.fill"
    case search = "square.grid.2x2"
    case cart = "cart.fill"
    case profile = "person.fill"
}

struct FloatingTabBar: View {
    @Binding var selectedTab: Tab
    @EnvironmentObject var cartVM: CartBadgeVM
//    @State var count = 0
    
    
    var body: some View {
        HStack(spacing: 30) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Button(action: { selectedTab = tab }) {
                    ZStack(alignment: .topTrailing) {
                        ZStack {
                            if selectedTab == tab {
                                Circle()
                                    .fill(Color.deepPurple.opacity(0.3))
                                    .frame(width: 44, height: 44)
                            }
                            Image(systemName: tab.rawValue)
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(selectedTab == tab ? .deepPurple : .gray)
                        }

                        if tab == .cart && cartVM.badgeCount > 0 {
                            Text("\((cartVM.badgeCount))")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Circle().fill(Color.red))
                                .offset(x: 10, y: -10).onAppear{
                                }
                        }
                    }
                }
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 30)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 10)
        .padding(.horizontal, 24)
    }
}


//#Preview {
//    FloatingTabBar()
//}
struct SearchView: View { var body: some View { Color.yellow.ignoresSafeArea().overlay(Text("Search")) } }
struct CartView: View { var body: some View { Color.blue.ignoresSafeArea().overlay(Text("Cart")) } }

