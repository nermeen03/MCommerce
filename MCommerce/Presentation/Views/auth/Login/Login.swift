import SwiftUI

struct Login: View {
    @StateObject var viewModel: LoginViewModel = DIContainer.shared.resolveLoginViewModel()
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
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
                
               
                
                CustomButton(
                    text: "Login",
                    textColor: .white,
                    backgroundColor: .deepPurple,
                    verticalOffset: 0,
                    action: { viewModel.login()
                    }
                ).onChange(of: viewModel.isLogged) { isLogged in
                    if isLogged {
                        coordinator.navigate(to: .main)
                    }
                }.padding(.top , 16)
                
               
                
             
                
                    HStack {
                        Text("Don't have an account? ")
                            .font(.callout)
                            .foregroundColor(.black)
                        Text("Sign Up")
                            .font(.callout)
                            .foregroundColor(.orangeCustom)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 16)
                    .onTapGesture {
                        coordinator.navigate(to: .signup)
                    }
                
//                NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true), isActive: $viewModel.isLogged) {
//                    EmptyView()
//                }
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .alert("Loading...", isPresented: $viewModel.isLoading) { }
            .alert(viewModel.errorMessage, isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) {}
            }
        
    }
}
