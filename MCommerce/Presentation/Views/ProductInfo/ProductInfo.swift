//
//  ProductInfo.swift
//  MCommerce
//
//  Created by Jailan Medhat on 18/06/2025.
//

import SwiftUI

struct ProductInfo: View {
    @StateObject var viewModel = ProductViewModel()
    @State private var selectedColor: String? = nil
    @State private var selectedSize: String? = nil


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ProductImagesSliderView(viewModel: viewModel)
                Text("Product title And info").font(.title).bold().padding()
                HStack {
                    Text("$").font(.title2).foregroundColor(.orangeCustom).bold()
                  
                    Text("1000").font(.title2).foregroundColor(.orangeCustom).bold()
                    Divider().frame(width: 10)
                    Text("Including Taxes and duties").font(.callout).foregroundColor(.gray)
                }.padding(.leading)
                
                HStack() {
                    Text("Available Colors")
                    Spacer()
                    ForEach(viewModel.availableColors, id: \.self) { colorHex in
                        Circle()
                            .fill(viewModel.colorFromName(colorHex))
                            .frame(width: 36, height: 36)
                            .overlay(
                                Circle()
                                    .stroke( Color.black , lineWidth: 2)
                            )
                            .onTapGesture {
                                selectedColor = colorHex
                            }
                    }
                }.frame(maxWidth: .infinity , alignment: .trailing).padding()
                HStack{
                    Text("Select Size")
                    Spacer()
                    HStack{
                        ForEach(viewModel.availableSizes, id: \.self) { size in
                                Text(size)
                                    .fontWeight(.medium)
                                    .frame(width: 40, height: 40)
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedSize == size ? Color.black : Color.gray.opacity(0.3), lineWidth: 2)
                                    )
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(selectedSize == size ? Color.gray.opacity(0.2) : Color.clear)
                                    )
                                    .onTapGesture {
                                        selectedSize = size
                                    }
                            }
                    }
                }.padding()
                Text("Description").padding(.top).padding(.leading).foregroundColor(.gray).bold()
                Text("""
                This stylish smartwatch blends cutting-edge features with modern design. Stay connected with notifications, track your health, and personalize your experience with a variety of bands and watch faces. Built for both function and fashion, it's your perfect everyday companion.
                """)
                .font(.body)
                .foregroundColor(.black)
                .padding(.horizontal).padding(.top ,8)

            }
            HStack{
                Button(action: {
                     // Favorite or like action
                 }) {
                     Image(systemName: "heart")
                         .resizable()
                         .scaledToFit()
                         .frame(width: 20, height: 20)
                         .foregroundColor(.deepPurple)
                         .padding(12)
                         .background(Circle().fill(Color.gray.opacity(0.1)))
                 }
                CustomButton(text: "Add to bag", textColor: .white, backgroundColor: .deepPurple, verticalOffset: 0, action:{})
            }.padding()
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    ProductInfo()
}
