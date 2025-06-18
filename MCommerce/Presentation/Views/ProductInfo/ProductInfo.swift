//
//  ProductInfo.swift
//  MCommerce
//
//  Created by Jailan Medhat on 18/06/2025.
//

import SwiftUI

struct ProductInfo: View {
    @StateObject var viewModel : ProductViewModel
//    @State private var selectedColor: String? = nil
//  @State  var selectedSize: String? = nil


    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ProductImagesSliderView(viewModel: viewModel)
                Text(viewModel.product?.title ?? "").font(.title).bold().padding()
                HStack {
                    if let selectedColor = viewModel.selectedColor,
                       let selectedSize = viewModel.selectedSize,
                        let price = viewModel.priceForSelected(color: selectedColor, size: selectedSize) {
                         
                         Text("$").font(.title2).foregroundColor(.orangeCustom).bold()
                         Text(price).font(.title2).foregroundColor(.orangeCustom).bold()
                     } else {
                         Text("999").font(.subheadline).foregroundColor(.gray)
                     }
                    Divider().frame(width: 10)
                    Text("Including Taxes and duties").font(.callout).foregroundColor(.gray)
                }.padding(.leading)
                
                HStack() {
                    Text("Available Colors").padding(.leading, 0).bold()
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
                                viewModel.selectedColor = colorHex
                            }
                    }
                }.frame(maxWidth: .infinity , alignment: .leading).padding(.vertical , 16).padding(.horizontal)
                SizePicker(viewModel: viewModel, selectedSize: $viewModel.selectedSize)
                Text("Description").padding(.top).padding(.leading).foregroundColor(.gray).bold()
                Text(viewModel.product?.description ?? "")
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


//#Preview {
//    ProductInfo()
//}
