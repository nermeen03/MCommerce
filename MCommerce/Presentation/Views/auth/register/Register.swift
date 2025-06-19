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
                    CustomButton(text: "Sign Up", textColor: .white, backgroundColor: .deepPurple, verticalOffset: 0) {
                        viewModel.register()
                    }
                    .padding(.top, 24)

                    // Alternative Sign-In Methods
                    Text("Or using another method ")
                        .font(.callout)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 24)
                        .padding(.bottom, 8)

                    CustomButton(text: "Continue with Google", textColor: .black, backgroundColor: .white, verticalOffset: 0, imageExist: true) {}

                    // Sign In Link
                        HStack {
                            Text("Already have an account?")
                                .font(.callout)
                                .foregroundColor(.black)

                            Text("Sign In")
                                .font(.callout)
                                .foregroundColor(.deepPurple)
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
            }.alert("Loading... \n Verifying your email.." , isPresented: $viewModel.isLoading){}
            .navigationBarBackButtonHidden(true)
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {}
            }
        
    }
}
