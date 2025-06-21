//
//  CheckoutView.swift
//  MCommerce
//
//  Created by abram on 21/06/2025.
//


import SwiftUI

struct CheckoutView: View {
    @State private var selectedShippingMethod = "Home delivery"
    @State private var selectedPaymentCard = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Product Section
                    HStack(spacing: 16) {
                        Image(systemName: "headphones")
                            .font(.system(size: 40))
                            .foregroundColor(.black)
                            .frame(width: 60, height: 60)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sony WH-1000XM5")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            HStack {
                                Text("$ 4.999")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                                
                                Text("Including taxes and duties")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    // Shipping Method Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Shipping method")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            ShippingMethodButton(
                                title: "Home delivery",
                                isSelected: selectedShippingMethod == "Home delivery"
                            ) {
                                selectedShippingMethod = "Home delivery"
                            }
                            
                            ShippingMethodButton(
                                title: "Pick up in store",
                                isSelected: selectedShippingMethod == "Pick up in store"
                            ) {
                                selectedShippingMethod = "Pick up in store"
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Payment Method Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Select your payment method")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            PaymentCardView(
                                cardNumber: "**** **** **** 1921",
                                expiryDate: "07/25",
                                gradient: LinearGradient(
                                    colors: [.pink, .orange],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                isSelected: selectedPaymentCard == 0
                            ) {
                                selectedPaymentCard = 0
                            }
                            
                            PaymentCardView(
                                cardNumber: "**** **** **** 5632",
                                expiryDate: "07/25",
                                gradient: LinearGradient(
                                    colors: [.purple, .blue],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                isSelected: selectedPaymentCard == 1
                            ) {
                                selectedPaymentCard = 1
                            }
                        }
                        .padding(.horizontal)
                        
                        // Add New Payment Methods
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Image(systemName: "plus")
                                    .foregroundColor(.black)
                                Text("Add new")
                                    .fontWeight(.medium)
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            HStack(spacing: 12) {
                                PaymentOptionButton(title: "Apple Pay", icon: "apple.logo")
                                PaymentOptionButton(title: "PayPal", icon: "p.circle.fill")
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Order Summary
                    VStack(spacing: 12) {
                        HStack {
                            Text("Subtotal (2 items)")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("$ 4.999")
                        }
                        
                        HStack {
                            Text("Shipping cost")
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Free")
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Total")
                                .font(.headline)
                                .fontWeight(.bold)
                            Spacer()
                            Text("$ 4.999")
                                .font(.headline)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Finalize Purchase Button
                    Button(action: {
                        // Handle purchase
                    }) {
                        Text("Finalize Purchase")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                LinearGradient(
                                    colors: [.orange, .red],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 28))
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Handle back action
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

struct ShippingMethodButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(isSelected ? .black : .gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(isSelected ? Color.black.opacity(0.1) : Color.gray.opacity(0.1))
                )
        }
    }
}

struct PaymentCardView: View {
    let cardNumber: String
    let expiryDate: String
    let gradient: LinearGradient
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("VISA")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.white)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
                
                Spacer()
                
                Text(cardNumber)
                    .font(.system(size: 16, weight: .medium, design: .monospaced))
                    .foregroundColor(.white)
                
                Text(expiryDate)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding(16)
            .frame(width: 160, height: 100)
            .background(gradient)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

struct PaymentOptionButton: View {
    let title: String
    let icon: String
    
    var body: some View {
        Button(action: {
            // Handle payment option selection
        }) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(.black)
                Text(title)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}
