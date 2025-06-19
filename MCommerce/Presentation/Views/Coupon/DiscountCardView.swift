//
//  CouponCardView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import SwiftUI

struct DiscountCardView: View {
    let discount: DiscountData
    @State private var showToast = false
    var body: some View {
        let random = Int.random(in: 1...5)
        
        ZStack {
            Image("coupon\(random)")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width - 40, height: 220)
                .clipped()
            
            HStack(spacing: 8){
                VStack{
                    Text(discount.percentage).font(.system(size: 50, weight: .heavy))
                        .foregroundColor(.white)
                    if let codes = discount.codes {
                        ForEach(codes, id: \.self) { code in
                            HStack {
                                Text("Code: \(code)")
                                    .font(.caption)
                                    .foregroundColor(.yellow)
                                    .padding(1)
                                    .background(Color.black.opacity(0.2))
                                    .cornerRadius(4)
                                    .textSelection(.enabled)
                                Button(action: {
                                    UIPasteboard.general.string = code
                                    showToast = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                            showToast = false
                                        }
                                    
                                }) {
                                    Image(systemName: "square.on.square").foregroundColor(.white)
                                }
                                .buttonStyle(BorderlessButtonStyle())
                                
                            }
                        }
                    }
                }.padding().toast(isShowing: $showToast, message: "Copied!")
                VStack(alignment: .leading, spacing: 6) {
                    Text(discount.title)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(2)
                        .cornerRadius(4)

                    if let summary = discount.summary{
                        Text(summary)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                            .padding(2)
                            .cornerRadius(4)
                    }
                    
                    
                    if let endsAt = discount.endsAt {
                        Text("Ends: \(endsAt)")
                            .font(.caption)
                            .foregroundColor(.yellow)
                            .padding(2)
                            .cornerRadius(4)
                    }
                }
            }.frame(width: UIScreen.main.bounds.width - 40, height: 150).background(Color.black.opacity(0.4))
        }
        .frame(width: UIScreen.main.bounds.width - 40,height: 150)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}


