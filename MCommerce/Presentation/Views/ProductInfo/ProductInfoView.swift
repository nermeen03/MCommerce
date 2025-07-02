//
//  ProductInfo.swift
//  MCommerce
//
//  Created by Jailan Medhat on 18/06/2025.
//

import SwiftUI

struct ProductInfoView: View {
    @StateObject var viewModel : ProductViewModel
//    @State private var selectedColor: String? = nil
//  @State  var selectedSize: String? = nil
    @State var showToast : Bool = false
    @EnvironmentObject var cartVM: CartBadgeVM


    var body: some View {
        VStack(spacing: 0) {
            
            if(viewModel.isLoading){
                VStack{
                    ProgressView().progressViewStyle(CircularProgressViewStyle()).scaleEffect(2)
                }.frame(maxWidth: .infinity, maxHeight: .infinity ).background(.white.opacity(0.7))
            }
            else{
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        ProductImagesSliderView(viewModel: viewModel)
                        Text(viewModel.product?.title ?? "")
                            .font(.title2)
                            .bold()
                            .padding()
                        
                        HStack {
                            if let price = viewModel.price {
                                Text("$".symbol)
                                    .font(.title2)
                                    .foregroundColor(.orangeCustom)
                                    .bold()
                                Text(price.currency)
                                    .font(.title2)
                                    .foregroundColor(.orangeCustom)
                                    .bold()
                            } else {
                                Text("999")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Divider().frame(width: 10)
                            Text("Including Taxes and duties")
                                .font(.callout)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading)
                        
                        HStack {
                            Text("Available Colors")
                                .padding(.leading, 0)
                                .bold()
                            Spacer()
                            ForEach(viewModel.availableColors, id: \.self) { colorHex in
                                Circle()
                                    .fill(viewModel.colorFromName(colorHex))
                                    .frame(width: 36, height: 36)
                                    .overlay(
                                        Circle()
                                            .stroke(Color.black, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        viewModel.selectedColor = colorHex
                                    }
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 16)
                        .padding(.horizontal)
                        
                        SizePicker(viewModel: viewModel, selectedSize: $viewModel.selectedSize)
                        
                        Text("Description")
                            .padding(.top)
                            .padding(.leading)
                            .foregroundColor(.gray)
                            .bold()
                        
                        Text(viewModel.product?.description ?? "")
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .padding(.top, 8)
                    }
                }
                
                
                Spacer()
                if (viewModel.isLoggedIn){
                    HStack {
                        Button(action: {
                            if viewModel.isFav {
                                viewModel.isAlertActive = true
                            }else{
                                viewModel.addToFav()
                                viewModel.isFav.toggle()
                            }
                            
                        }) {
                            Image(systemName: viewModel.isFav ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.deepPurple)
                                .padding(12)
                                .background(Circle().fill(Color.gray.opacity(0.1)))
                        }
                        
                        CustomButton(
                            text: "Add to bag",
                            textColor: .white,
                            backgroundColor: .deepPurple,
                            verticalOffset: 0,
                            action: {
                                viewModel.addToCart()
                                cartVM.badgeCount += 1
                                showToast = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    showToast = false
                                }
                            }
                        )
                    }
                    .padding(.horizontal)}
                
                
            }}.toast(isShowing: $showToast, message: "Saved to cart!")
        .onChange(of: viewModel.selectedColor) { _ in
            viewModel.updatePriceForSelection()
        }
        .onChange(of: viewModel.selectedSize) { _ in
            viewModel.updatePriceForSelection()
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).alert("Are You sure you want to remove this item From favorites ?", isPresented: $viewModel.isAlertActive){
            Button("Yes" ,role : .destructive) {
                viewModel.deleteFromFav()
                viewModel.isAlertActive = false
                viewModel.isFav.toggle()
            }
            Button("No" ,role : .cancel){
                viewModel.isAlertActive = false
            }
        }
    }

}


//#Preview {
//    ProductInfo()
//}
