//
//  UserDefaults.swift
//  ClockSnd
//
//  Created by Vlady on 31.03.2024.
//

import Foundation

final class SndUserDefaults {
    public static let sndTheme = "app_settings_theme"
    public static let sndNeverSleep = "app_settings_never_sleep"
    public static let sndSleepTime = "app_settings_sleep_time"
    public static let sndMotionSensitivity = "app_settings_motion_sensitivity"
    public static let sndOnboarding = "app_onboarding"

    
    @UserDefault(key: SndUserDefaults.sndOnboarding, defaultValue: false)
    static var onboarding: Bool
    
    @UserDefault(key: SndUserDefaults.sndTheme, defaultValue: 0)
    static var theme: Theme.RawValue
    
    @UserDefault(key: SndUserDefaults.sndNeverSleep, defaultValue: false)
    static var neverSleep: Bool

    @UserDefault(key: SndUserDefaults.sndSleepTime, defaultValue: 15)
    static var sleepTime: Int

    @UserDefault(key: SndUserDefaults.sndMotionSensitivity, defaultValue: 0.03)
    static var motionSensitivity: Double

    init() {}
}

enum Theme: Int {
    case `default`
    case light
    case dark
}

@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T
    var container: UserDefaults = .standard

    var wrappedValue: T {
        get {
            return container.object(forKey: key) as? T ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}
