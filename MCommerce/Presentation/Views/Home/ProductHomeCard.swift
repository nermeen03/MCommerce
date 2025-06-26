//
//  ProductHomeCard.swift
//  MCommerce
//
//  Created by abram on 26/06/2025.
//
import SwiftUI


struct ProductHomeCard: View {
    let imageUrl: String
    let title: String
    let price: String
    let backgroundColor: Color = Color.randomPastel()

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack {
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                } placeholder: {
                    Color.gray.opacity(0.2)
                        .frame(width: 120, height: 120)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)


            Text(title)
                .font(.headline)
                .foregroundColor(.black)
                .lineLimit(2)
                .padding(.horizontal, 8)

            Text(price)
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal, 8)
        }
        .frame(width: 180, height: 200)
        .background(backgroundColor.opacity(0.3))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 5)
    }
}

extension Color {
    static func randomPastel() -> Color {
        return Color(
            red: Double.random(in: 0.6...0.9),
            green: Double.random(in: 0.6...0.9),
            blue: Double.random(in: 0.6...0.9)
        )
    }
}


//struct ProductView: View {
//    var body: some View {
//        HStack(spacing: 20) {
//            // Updated to use ProductHomeCard
//            ProductHomeCard(imageName: "huaweiMatebook", title: "Huawei Matebook X13", price: "$ 20,999", backgroundColor: Color(red: 0.98, green: 0.94, blue: 0.94))
//
//            // Updated to use ProductHomeCard
//            ProductHomeCard(imageName: "alexaHome", title: "Alexa Home", price: "$ 999", backgroundColor: Color(red: 0.98, green: 0.96, blue: 0.92))
//        }
//    }
//}

//struct ProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductView()
//    }
//}
