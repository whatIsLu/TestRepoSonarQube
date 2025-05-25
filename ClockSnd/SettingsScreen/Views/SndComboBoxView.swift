//
//  SndComboBox.swift
//  ClockSnd
//
//  Created by Vlady on 31.03.2024.
//

import SwiftUI

struct SndComboBoxView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel: SndComboBoxViewModel
    var color: Color = .primary
    @State var currentValue: Int = -1

    var body: some View {
        VStack {
            viewModel.coordinator.defaultNavigationBar
                .foregroundColor(colorScheme == .light ? .black : .white)
            
            ForEach(0..<viewModel.getOptions.count, id: \.self) { index in
                let item = viewModel.getOptions[index]
                Button(action: {
                    self.viewModel.changeValue(value: item.1)
                    self.currentValue = index
                    ThemeManager.shared.configure()
                }) {
                    HStack {
                        SndText(style: .bold, item.0)
                            .font(.headline)
                            .foregroundColor(color)
                        Spacer()
                        if viewModel.equals(value: item.1) || currentValue == index {
                            Image(systemName: "checkmark.square.fill")
                        } else {
                            Image(systemName: "square")
                        }
                    }
                    .padding(.horizontal, 15)
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
                .foregroundColor(.primary)
            }
            
        }
        .padding()
    }
}
