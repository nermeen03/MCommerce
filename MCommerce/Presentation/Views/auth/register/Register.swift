//
//  Register.swift
//  WelcomeScreenDemo
//
//  Created by Jailan Medhat on 16/06/2025.
//

import SwiftUI

struct Register: View {
   @StateObject private var viewModel = RegisterViewModel()
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Create Account").font(.title2).bold()
                Text("Start shopping by creating an account").font(.subheadline).foregroundColor(.gray)
                CustomTF(text: $viewModel.name , imagePrefix: "profile" , hint: "Enter your  Name",title: "Name" , errorMessage: $viewModel.nameError) { value in
                    viewModel.validateName(value)
                    
                }
                CustomTF(text: $viewModel.email , imagePrefix: "email" , hint: "Enter your email address",title: "Email"
                         , errorMessage: $viewModel.emailError) { value in
                    viewModel.validateEmail(value)
                    
                }
                CustomTF(text: $viewModel.phoneNumber , imagePrefix: "phone" , hint: "Enter your Phone Number",title: "Phone Number", errorMessage: $viewModel.phoneNumberError) { value in
                    viewModel.validatePhoneNumber(value)
                    
                }
                CustomTF(text: $viewModel.password , imagePrefix: "password" , hint: "Enter your password",title: "Password", isSecure: true, errorMessage: $viewModel.passwordError) { value in
                    viewModel.validatePassword(value)
                    
                    
                }
                CustomTF(text: $viewModel.confirmPassword , imagePrefix: "password" , hint: "Re-enter your password",title: "Confirm Password", isSecure: true, errorMessage: $viewModel.confirmPasswordError) { value in
                    viewModel.validateConfirmPassword(value)
                    
                
                    
                }
                
                
                CustomButton(text: "Sign Up", textColor: .white, backgroundColor: .deepPurple ,verticalOffset: 0 , action:  {}).padding(.top ,24)
                
                Text("Or using another method ").font(.callout).foregroundColor(.gray).frame(maxWidth : .infinity, alignment:  .center).padding(.top, 24).padding(.bottom ,8)
                CustomButton(text: "Countinue with Google", textColor: .black, backgroundColor: .white ,verticalOffset: 0 , imageExist: true, action:  {},)
              //  NavigationLink(destination: Login()){
                HStack{
                    Text("Already have an account? ").font(.callout).foregroundColor(.black)
                   
                        Text("Sign In").font(.callout).foregroundColor(.deepPurple)
                        
                        
                        
                    }.frame(maxWidth : .infinity, alignment:  .center).padding(.vertical , 16)}
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading).padding()
            
            
        }}
  //  }


#Preview {
    Register()
}
