//
//  CustomTF.swift
//  WelcomeScreenDemo
//
//  Created by Jailan Medhat on 16/06/2025.
//

import SwiftUI

struct CustomTF: View {
    @Binding var text: String
    var imagePrefix : String
    var hint : String
    
    var title : String
    var isSecure : Bool? = nil
    @State private var isPasswordVisible: Bool = false
    @Binding  var errorMessage: String
    var validator : (String) -> Void
    
  
    var body: some View {
        Text(title).font(.title3).fontWeight(.medium).padding(.top, 16)
        
        HStack{
            Image(imagePrefix).resizable().frame(width: 24, height: 24).padding(.top , 8).padding(.trailing, 8)
            Group {
                           if isSecure == true && !isPasswordVisible {
                               SecureField(hint, text: $text)
                           } else {
                               TextField(hint, text: $text)
                           }
                       }
                       .onChange(of: text) { value in
                            validator(value)
                       }
                       .padding(.top, 8)
            
            if let secured = isSecure {
                Button(action: {
                    isPasswordVisible.toggle()
                }) {
                    Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill").resizable().frame(width: 24, height: 20)
                        .foregroundColor(.gray) 
                }.padding(.trailing,16).padding(.top,8)
            }
        }.padding([.bottom , .leading],16).padding(.top,8)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.gray, lineWidth: 0.3))
        if !errorMessage.isEmpty{
            Text(errorMessage).font(.footnote).foregroundColor(.red).padding(.leading)
        }
        
    }
    
}

//#Preview {
//    CustomTF(email: "")
//}
