import SwiftUI

struct Register: View {
    @StateObject private var viewModel = DIContainer.shared.resolveRegisterViewModel()
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Create Account").font(.title2).bold()
                    Text("Start shopping by creating an account")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    // Input Fields
                    CustomTF(text: $viewModel.name, imagePrefix: "profile", hint: "Enter your Name", title: "Name", errorMessage: $viewModel.nameError) { value in
                        viewModel.validateName(value)
                    }

                    CustomTF(text: $viewModel.email, imagePrefix: "email", hint: "Enter your email address", title: "Email", errorMessage: $viewModel.emailError) { value in
                        viewModel.validateEmail(value)
                    }

                    CustomTF(text: $viewModel.phoneNumber, imagePrefix: "phone", hint: "Enter your Phone Number", title: "Phone Number", errorMessage: $viewModel.phoneNumberError) { value in
                        viewModel.validatePhoneNumber(value)
                    }

                    CustomTF(text: $viewModel.password, imagePrefix: "password", hint: "Enter your password", title: "Password", isSecure: true, errorMessage: $viewModel.passwordError) { value in
                        viewModel.validatePassword(value)
                    }

                    CustomTF(text: $viewModel.confirmPassword, imagePrefix: "password", hint: "Re-enter your password", title: "Confirm Password", isSecure: true, errorMessage: $viewModel.confirmPasswordError) { value in
                        viewModel.validateConfirmPassword(value)
                    }

                    // Sign Up Button
                    CustomButton(
                        text: "Sign Up",
                        textColor: .white,
                        backgroundColor: .deepPurple,
                        verticalOffset: 16,
                        action: { viewModel.register()
                        }
                    ).onChange(of: viewModel.isRegistered) { isRegistered in
                        if isRegistered {
                            coordinator.navigate(to: .main)
                        }
                    }

               
                        HStack {
                            Text("Already have an account?")
                                .font(.callout)
                                .foregroundColor(.black)

                            Text("Sign In")
                                .font(.callout)
                                .foregroundColor(.orangeCustom)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 16)
                        .onTapGesture {
                            coordinator.navigate(to: .login)
                        }

//                    // ✅ This NavigationLink is triggered by ViewModel
//                    NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $viewModel.isRegistered) {
//                        EmptyView()
//                    }
                }
                .padding()
            }.alert("Loading... \n Verifying your email.." , isPresented: $viewModel.isLoading){
                Button("Dismiss"){
               
                   
                }
            }
            .navigationBarBackButtonHidden(false)
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                Button("Dismiss", role: .cancel) {
                    viewModel.errorMessage = ""
                    viewModel.showError = false
                }
            }
        
    }
}
