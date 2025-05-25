//
//  SndTextField.swift
//  ClockSnd
//
//  Created by Vlady on 03.09.2023.
//

import SwiftUI

enum FieldType {
    case login
    case password
    case userName
}

struct SndTextField: View {
    @Binding var text: String
    let fieldType: FieldType
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8.0)
                .foregroundColor(.white)
            fieldView
        }
        .frame(height: 50)
        .padding(.vertical, 10)
        .cornerRadius(12.0)
        .shadow(radius: 4)
    }
    
    @ViewBuilder
    private var fieldView: some View {
        switch fieldType {
        case .login:
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text("Email")
                        .font(.customFont(family: .nunito, style: .bold, size: 16))
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                }
                TextField("", text: $text)
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .font(.customFont(family: .nunito, style: .bold, size: 16))
                    .foregroundColor(.black)
            }
            
        case .password:
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text("Password")
                        .font(.customFont(family: .nunito, style: .bold, size: 16))
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                }
                SecureField("", text: $text)
                    .padding()
                    .font(.customFont(family: .nunito, style: .bold, size: 16))
                    .foregroundColor(.black)
            }
        case .userName:
            ZStack(alignment: .leading) {
                if text.isEmpty {
                    Text("Username")
                        .font(.customFont(family: .nunito, style: .bold, size: 16))
                        .foregroundColor(.gray)
                        .padding(.leading, 16)
                }
                TextField("", text: $text)
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .font(.customFont(family: .nunito, style: .bold, size: 16))
                    .foregroundColor(.black)
            }
        }
    }
}
