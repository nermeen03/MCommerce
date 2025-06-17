//
//  CouponCardView.swift
//  MCommerce
//
//  Created by Nermeen Mohamed on 17/06/2025.
//

import SwiftUI

struct CouponCardView: View {
    let discount: Discount

    var body: some View {
        let random = Int.random(in: 1...5)
        
        ZStack {
            Image("coupon\(random)")
                .resizable()
                .scaledToFill()
                .frame(width: 250, height: 200)
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(discount.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(4)
                    .background(Color.black.opacity(0.3))
                    .cornerRadius(4)

                Text(discount.summary ?? "")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.4))
                    .padding(4)
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(4)
                
                if let codes = discount.codes?.nodes {
                    ForEach(codes, id: \.code) { code in
                        Text("Code: \(code.code)")
                            .font(.caption)
                            .foregroundColor(.yellow)
                            .padding(4)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(4)
                    }
                }
                if let endsAt = discount.endsAt {
                    Text("Ends: \(endsAt)")
                        .font(.caption)
                        .foregroundColor(.yellow)
                        .padding(4)
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(4)
                }
            }
            .padding()
        }
        .frame(width: 250, height: 150)
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}
