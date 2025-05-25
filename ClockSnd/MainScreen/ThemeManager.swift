//
//  ThemeManager.swift
//  ClockSnd
//
//  Created by Vlady on 31.03.2024.
//

import SwiftUI
import UIKit

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var colorScheme: ColorScheme 
    
    init() {
        self.colorScheme = .dark
        self.configure()
    }
    
    func configure() {
        guard let theme = Theme(rawValue: SndUserDefaults.theme) else { return }
        switch theme {
        case .default:
            SndUserDefaults.theme = 0
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                if windowScene.traitCollection.userInterfaceStyle == .dark {
                    self.colorScheme = .dark
                } else {
                    self.colorScheme = .light
                }
            } else {
                self.colorScheme = .dark
            }
        case .light:
            SndUserDefaults.theme = 1
            self.colorScheme = .light
        case .dark:
            SndUserDefaults.theme = 2
            self.colorScheme = .dark
        }
    }
    
    var systemInterfaceStyle: UIUserInterfaceStyle {
        return UITraitCollection.current.userInterfaceStyle
    }
}
