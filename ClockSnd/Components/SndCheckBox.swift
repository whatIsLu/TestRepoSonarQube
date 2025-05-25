//
//  SndCheckBox.swift
//  ClockSnd
//
//  Created by Vlady on 31.03.2024.
//

import Foundation
import SwiftUI

struct SndCheckBox: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Binding var isChecked: Bool
    var label: String
    var color: Color = .primary
    
    var body: some View {
        HStack {
            SndText(style: .bold, label)
                .font(.headline)
                .foregroundColor(color)
                .padding(.horizontal, 15)
            Spacer()
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .padding(.horizontal, 15)
                .onTapGesture {
                    self.isChecked.toggle()
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 15)
        .background(Color.clear)
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.clear)
                .background(
                    Color.white
                        .opacity(colorScheme == .dark ? 0.1 : 0.9)
                )
                .cornerRadius(10)
        )
        .shadow(color: colorScheme == .dark ? Color.customColor4 : Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
