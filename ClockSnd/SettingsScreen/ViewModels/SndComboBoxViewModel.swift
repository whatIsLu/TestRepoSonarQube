//
//  SndComboBoxViewModel.swift
//  ClockSnd
//
//  Created by Vlady on 31.03.2024.
//

import Foundation

class SndComboBoxViewModel: ObservableObject {
    @Published var coordinator: MainCoordinator
    let optionConfig: SettingsConfiguration

    var option: Any {
        switch optionConfig {
        case .sensitivity:
            SndUserDefaults.motionSensitivity
        case .theme:
            SndUserDefaults.theme
        case .sleepTime:
            SndUserDefaults.sleepTime
        }
    }
    
    var getOptions: [(String, Any)] {
        switch optionConfig {
        case .sensitivity:
            return [("Very High", 0.01), ("High", 0.02), ("Normal", 0.03), ("Low", 0.1), ("Very Low", 0.8)]
        case .theme:
            return [("Default", 0), ("Light", 1), ("Dark", 2)]
        case .sleepTime:
            return [("Very Fast", 15), ("Fast", 30), ("Normal", 60), ("Slow", 90), ("Very Slow", 120)]
        }
    }
    
    func equals(value: Any) -> Bool {
        switch optionConfig {
        case .sensitivity:
            guard let value = value as? Double else { return false}
            return SndUserDefaults.motionSensitivity == value
        case .theme:
            guard let value = value as? Int, let theme = Theme(rawValue: value) else { return false}
            return SndUserDefaults.theme == theme.rawValue
        case .sleepTime:
            guard let value = value as? Int else { return false }
            return SndUserDefaults.sleepTime == value
            
        }
    }
    
    func changeValue(value: Any) {
        switch optionConfig {
        case .sensitivity:
            guard let value = value as? Double else { return }
            SndUserDefaults.motionSensitivity = value
        case .theme:
            guard let value = value as? Int else { return }
            SndUserDefaults.theme = value
        case .sleepTime:
            guard let value = value as? Int else { return }
            SndUserDefaults.sleepTime = value
        }
    }

    init(optionConfig: SettingsConfiguration, coordinator: MainCoordinator) {
        self.coordinator = coordinator
        self.optionConfig = optionConfig
    }
}
