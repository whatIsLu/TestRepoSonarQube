//
//  ClockSndApp.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

@main
struct ClockSndApp: App {
    @Environment(\.colorScheme) var systemColorScheme: ColorScheme
    @ObservedObject var themeManager = ThemeManager.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.colorScheme, themeManager.colorScheme)
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    ThemeManager.shared.configure()
                }
        }
    }
}
