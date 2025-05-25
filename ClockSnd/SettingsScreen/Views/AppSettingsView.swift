//
//  AppSettingsView.swift
//  ClockSnd
//
//  Created by Vlady on 31.03.2024.
//

import Foundation
import SwiftUI

struct AppSettingsView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel: AppSettingsViewModel
    @State var neverSleep: Bool = SndUserDefaults.neverSleep

    var body: some View {
        VStack {
            viewModel.coordinator.defaultNavigationBar
                .foregroundColor(colorScheme == .light ? .black : .white)
            
            settingsButton(label: "Theme") {
                viewModel.coordinator.push(page: .comboBox(configuration: .theme))
            }
            SndCheckBox(isChecked: $neverSleep, label: "Never sleep")
                .onChange(of: neverSleep) {
                    SndUserDefaults.neverSleep = neverSleep
                }
            settingsButton(label: "Sleep time", action: {
                viewModel.coordinator.push(page: .comboBox(configuration: .sleepTime))
            }).sndDisabled(neverSleep)
            settingsButton(label: "Motion awake sensitivity", action: {
                viewModel.coordinator.push(page: .comboBox(configuration: .sensitivity))
            }).sndDisabled(neverSleep)
            Spacer()
        }
        .padding()
    }
    
    func settingsButton(label: String, view: AnyView = AnyView(Image(systemName: "chevron.right").foregroundColor(.gray)), color: Color = .primary, action: @escaping () -> Void = {}) -> some View {
        Button(action: action) {
            HStack {
                SndText(style: .bold, label)
                    .font(.headline)
                    .foregroundColor(color)
                
                Spacer()
                view
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
    }
}
