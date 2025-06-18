import SwiftUI

struct Login: View {
    @StateObject var viewModel: LoginViewModel = DIContainer.shared.resolveLoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Login Account").font(.title2).bold()
                Text("Please log in with your registered account")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                CustomTF(text: $viewModel.email, imagePrefix: "email", hint: "Enter your email address", title: "Email", errorMessage: $viewModel.emailError) { value in
                    viewModel.validateEmail(value)
                }
                
                CustomTF(text: $viewModel.password, imagePrefix: "password", hint: "Enter your password", title: "Password", isSecure: true, errorMessage: $viewModel.passwordError) { value in
                    viewModel.validatePassword(value)
                }
                
                Text("Forgot your password?")
                    .foregroundColor(.orangeCustom)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding()
                    .onTapGesture {
                        // Handle forgot password
                    }
                
                CustomButton(
                    text: "Login",
                    textColor: .white,
                    backgroundColor: .deepPurple,
                    verticalOffset: 0,
                    action: { viewModel.login() }
                )
                
                Text("Or using another method")
                    .font(.callout)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.top, 24)
                    .padding(.bottom, 8)
                
                CustomButton(
                    text: "Sign In with Google",
                    textColor: .black,
                    backgroundColor: .white,
                    verticalOffset: 0,
                    imageExist: true,
                    action: {}
                )
                
                NavigationLink(destination: Register()) {
                    HStack {
                        Text("Don't have an account? ")
                            .font(.callout)
                            .foregroundColor(.black)
                        Text("Sign Up")
                            .font(.callout)
                            .foregroundColor(.deepPurple)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 16)
                }

                
                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $viewModel.isLogged) {
                    EmptyView()
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .alert("Loading...", isPresented: $viewModel.isLoading) { }
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {}
            }
        }
    }
}
