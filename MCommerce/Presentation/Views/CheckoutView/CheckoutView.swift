////
////  CheckoutView.swift
////  MCommerce
////
////  Created by abram on 21/06/2025.
////
//
//
//import SwiftUI
//
//struct CheckoutView: View {
//    @EnvironmentObject var cartManager: CartManager
//    @State private var selectedShippingMethod = "Home delivery"
//    @State private var selectedPaymentCard = 0
//    @State private var couponCode: String = ""
//    @State private var isCouponApplied = false
//    @State private var discountPercentage: Double = 0.0
//    @ObservedObject var addressViewModel: AddressViewModel
//    @State private var selectedAddressId: String? = nil
//    @ObservedObject var paymentHandler = StripePaymentHandler()
//    @State private var isPresentingPaymentSheet = false
//
//
//    var body: some View {
//        NavigationView {
//            ScrollView {
//                VStack(spacing: 24) {
//
//                    // 🛒 Product List Section
//                    ForEach(cartManager.items) { item in
//                        HStack(spacing: 16) {
//                            Image(systemName: "cart") // Placeholder
//                                .font(.system(size: 40))
//                                .foregroundColor(.black)
//                                .frame(width: 60, height: 60)
//                                .background(Color.gray.opacity(0.1))
//                                .clipShape(RoundedRectangle(cornerRadius: 12))
//
//                            VStack(alignment: .leading, spacing: 4) {
//                                Text(item.name)
//                                    .font(.title2)
//                                    .fontWeight(.semibold)
//
//                                HStack {
//                                    Text("$ \(item.price, specifier: "%.2f") x \(item.quantity)")
//                                        .font(.title2)
//                                        .fontWeight(.bold)
//                                        .foregroundColor(.orange)
//
//                                    Text("Including taxes")
//                                        .font(.caption)
//                                        .foregroundColor(.gray)
//                                }
//                            }
//                            Spacer()
//                        }
//                        .padding(.horizontal)
//                    }
//
//                    // 🚚 Shipping Method Section
//                    VStack(alignment: .leading, spacing: 16) {
//                                        Text("Select a shipping address")
//                                            .font(.headline)
//                                            .padding(.horizontal)
//
//                                        if addressViewModel.isLoading {
//                                            ProgressView()
//                                                .padding()
//                                        } else if addressViewModel.addresses.isEmpty {
//                                            Text("No addresses available.")
//                                                .foregroundColor(.gray)
//                                                .padding(.horizontal)
//                                        } else {
//                                            ForEach(addressViewModel.addresses, id: \.id) { address in
//                                                Button(action: {
//                                                    selectedAddressId = address.id
//                                                }) {
//                                                    VStack(alignment: .leading, spacing: 4) {
//                                                        HStack {
//                                                            Text(address.address1)
//                                                                .font(.subheadline)
//                                                                .fontWeight(.medium)
//                                                            Spacer()
//                                                            if selectedAddressId == address.id {
//                                                                Image(systemName: "checkmark.circle.fill")
//                                                                    .foregroundColor(.green)
//                                                            }
//                                                        }
//
//                                                        Text(address.address2)
//                                                            .font(.caption)
//                                                            .foregroundColor(.gray)
//
//                                                        Text("Phone: \(address.phone)")
//                                                            .font(.caption2)
//                                                            .foregroundColor(.secondary)
//                                                    }
//                                                    .padding()
//                                                    .background(
//                                                        RoundedRectangle(cornerRadius: 10)
//                                                            .stroke(selectedAddressId == address.id ? Color.blue : Color.gray.opacity(0.3), lineWidth: 1)
//                                                    )
//                                                }
//                                                .padding(.horizontal)
//                                            }
//                                        }
//                                    }
//
//                    // 💳 Payment Method Section
//                    VStack(alignment: .leading, spacing: 16) {
//                        Text("Select your payment method")
//                            .font(.headline)
//                            .padding(.horizontal)
//
//                        HStack(spacing: 12) {
//                            PaymentCardView(
//                                cardNumber: "**** **** **** 1921",
//                                expiryDate: "07/25",
//                                gradient: LinearGradient(
//                                    colors: [.pink, .orange],
//                                    startPoint: .topLeading,
//                                    endPoint: .bottomTrailing
//                                ),
//                                isSelected: selectedPaymentCard == 0
//                            ) {
//                                selectedPaymentCard = 0
//                            }
//
//                            PaymentCardView(
//                                cardNumber: "**** **** **** 5632",
//                                expiryDate: "07/25",
//                                gradient: LinearGradient(
//                                    colors: [.purple, .blue],
//                                    startPoint: .topLeading,
//                                    endPoint: .bottomTrailing
//                                ),
//                                isSelected: selectedPaymentCard == 1
//                            ) {
//                                selectedPaymentCard = 1
//                            }
//                        }
//                        .padding(.horizontal)
//
//                        // ➕ Add Payment Option
//                        VStack(alignment: .leading, spacing: 12) {
//                            HStack {
//                                Image(systemName: "plus")
//                                    .foregroundColor(.black)
//                                Text("Add new")
//                                    .fontWeight(.medium)
//                                Spacer()
//                            }
//                            .padding(.horizontal)
//
//                            HStack(spacing: 12) {
//                                PaymentOptionButton(title: "Apple Pay", icon: "apple.logo")
//                                PaymentOptionButton(title: "PayPal", icon: "p.circle.fill")
//                            }
//                            .padding(.horizontal)
//                        }
//                    }
//                    // 💸 Coupon Section
//                    VStack(alignment: .leading, spacing: 12) {
//                        Text("Have a coupon?")
//                            .font(.headline)
//                            .padding(.horizontal)
//
//                        HStack {
//                            TextField("Enter coupon code", text: $couponCode)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .padding(.horizontal)
//
//                            Button(action: {
//                                if couponCode.lowercased() == "discount20" {
//                                    discountPercentage = 0.20
//                                    isCouponApplied = true
//                                } else {
//                                    discountPercentage = 0.0
//                                    isCouponApplied = false
//                                }
//                            }) {
//                                Text("Apply")
//                                    .font(.subheadline)
//                                    .fontWeight(.medium)
//                                    .foregroundColor(.white)
//                                    .padding(.horizontal, 12)
//                                    .padding(.vertical, 8)
//                                    .background(Color.blue)
//                                    .cornerRadius(8)
//                            }
//                            .padding(.trailing)
//                        }
//
//                        if isCouponApplied {
//                            Text(" 20% discount applied!")
//                                .font(.caption)
//                                .foregroundColor(.green)
//                                .padding(.horizontal)
//                        } else if !couponCode.isEmpty {
//                            Text(" Invalid coupon")
//                                .font(.caption)
//                                .foregroundColor(.red)
//                                .padding(.horizontal)
//                        }
//                    }
//
//                    // 🧾 Order Summary
//                    // 🧾 Order Summary
//                    let subtotal = cartManager.totalPrice()
//                    let discountAmount = subtotal * discountPercentage
//                    let total = subtotal - discountAmount
//
//                    VStack(spacing: 12) {
//                        HStack {
//                            Text("Subtotal (\(cartManager.items.count) items)")
//                                .foregroundColor(.gray)
//                            Spacer()
//                            Text("$ \(subtotal, specifier: "%.2f")")
//                        }
//
//                        HStack {
//                            Text("Shipping cost")
//                                .foregroundColor(.gray)
//                            Spacer()
//                            Text("Free")
//                        }
//
//                        if isCouponApplied {
//                            HStack {
//                                Text("Coupon Discount")
//                                    .foregroundColor(.green)
//                                Spacer()
//                                Text("- $ \(discountAmount, specifier: "%.2f")")
//                                    .foregroundColor(.green)
//                            }
//                        }
//
//                        Divider()
//
//                        HStack {
//                            Text("Total")
//                                .font(.headline)
//                                .fontWeight(.bold)
//                            Spacer()
//                            Text("$ \(total, specifier: "%.2f")")
//                                .font(.headline)
//                                .fontWeight(.bold)
//                        }
//                    }
//                    .padding(.horizontal)
//
//                    // ✅ Finalize Purchase Button
//                    Button(action: {
//                        let subtotal = cartManager.totalPrice()
//                        let discountAmount = subtotal * discountPercentage
//                        let total = subtotal - discountAmount
//
//                        paymentHandler.preparePaymentSheet(amount: Int(total * 100)) { success in
//                            if success {
//                                DispatchQueue.main.async {
//                                    isPresentingPaymentSheet = true
//                                }
//                            } else {
//                                print("❌ Failed to prepare PaymentSheet")
//                            }
//                        }
//                    }) {
//                        Text("Finalize Purchase")
//                            .font(.headline)
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity)
//                            .frame(height: 56)
//                            .background(
//                                LinearGradient(colors: [.orange, .red], startPoint: .leading, endPoint: .trailing)
//                            )
//                            .clipShape(RoundedRectangle(cornerRadius: 28))
//                    }
//                    .padding(.horizontal)
//                    .padding(.bottom, 20)
//                    .sheet(isPresented: $isPresentingPaymentSheet) {
//                        paymentHandler.presentPaymentSheet()
//                    }
//                }
//            }
//            .navigationTitle("Checkout")
//            .navigationBarTitleDisplayMode(.inline)
//            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        // Handle back
//                    }) {
//                        Image(systemName: "chevron.left")
//                            .foregroundColor(.black)
//                    }
//                }
//            }
//            .onAppear {
//                if addressViewModel.addresses.isEmpty {
//                    addressViewModel.fetchAddresses()
//                }
//            }
//        }
//    }
//}
//
//
//struct ShippingMethodButton: View {
//    let title: String
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            Text(title)
//                .font(.system(size: 16, weight: .medium))
//                .foregroundColor(isSelected ? .black : .gray)
//                .padding(.horizontal, 20)
//                .padding(.vertical, 12)
//                .background(
//                    RoundedRectangle(cornerRadius: 25)
//                        .fill(isSelected ? Color.black.opacity(0.1) : Color.gray.opacity(0.1))
//                )
//        }
//    }
//}
//
//struct PaymentCardView: View {
//    let cardNumber: String
//    let expiryDate: String
//    let gradient: LinearGradient
//    let isSelected: Bool
//    let action: () -> Void
//    
//    var body: some View {
//        Button(action: action) {
//            VStack(alignment: .leading, spacing: 8) {
//                HStack {
//                    Text("VISA")
//                        .font(.headline)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                    
//                    Spacer()
//                    
//                    if isSelected {
//                        Image(systemName: "checkmark.circle.fill")
//                            .foregroundColor(.white)
//                            .background(Color.green)
//                            .clipShape(Circle())
//                    }
//                }
//                
//                Spacer()
//                
//                Text(cardNumber)
//                    .font(.system(size: 16, weight: .medium, design: .monospaced))
//                    .foregroundColor(.white)
//                
//                Text(expiryDate)
//                    .font(.caption)
//                    .foregroundColor(.white.opacity(0.8))
//            }
//            .padding(16)
//            .frame(width: 160, height: 100)
//            .background(gradient)
//            .clipShape(RoundedRectangle(cornerRadius: 12))
//        }
//    }
//}
//
//struct PaymentOptionButton: View {
//    let title: String
//    let icon: String
//    
//    var body: some View {
//        Button(action: {
//            // Handle payment option selection
//        }) {
//            HStack(spacing: 8) {
//                Image(systemName: icon)
//                    .foregroundColor(.black)
//                Text(title)
//                    .fontWeight(.medium)
//                    .foregroundColor(.black)
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 12)
//            .background(
//                RoundedRectangle(cornerRadius: 8)
//                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
//            )
//        }
//    }
//}
//
////struct CheckoutView_Previews: PreviewProvider {
////    static var previews: some View {
////        let cartManager = CartManager()
////        cartManager.addItem(CartItem(name: "Sony WH-1000XM5", price: 4999.0, quantity: 1))
////
////        return CheckoutView()
////            .environmentObject(cartManager)
////    }
////}
//
//struct CheckoutView_Previews: PreviewProvider {
//    static var previews: some View {
//        let cartManager = CartManager()
//        cartManager.addItem(CartItemManager(name: "Sony WH-1000XM5", price: 4999.0, quantity: 1))
//
//        let dummyUseCases = AddressUseCases() 
//        let addressVM = AddressViewModel(addressUseCases: dummyUseCases)
//        addressVM.addresses = [
//                   AddressInfo(
//                       defaultAddress: true,
//                       id: "1",
//                       address1: "123 Main St",
//                       address2: "Apt 4",
//                       city: "Cairo",
//                       country: "Egypt",
//                       phone: "01012345678",
//                       type: "Home"
//                   ),
//                   AddressInfo(
//                       defaultAddress: false,
//                       id: "2",
//                       address1: "456 Nile Ave",
//                       address2: "Floor 2",
//                       city: "Giza",
//                       country: "Egypt",
//                       phone: "01087654321",
//                       type: "Work"
//                   )
//               ]
//
//        return CheckoutView(addressViewModel: addressVM)
//            .environmentObject(cartManager)
//    }
//}
