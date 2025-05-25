//
//  Color+Extensions.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import SwiftUI

extension Color {
    static let customColor1 = Color(red: 254 / 255, green: 253 / 255, blue: 238 / 255)
    static let customColor2 = Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255)
    static let customColor3 = Color(red: 246 / 255, green: 73 / 255, blue: 76 / 255)
    static let customColor4 = Color(red: 24 / 255, green: 24 / 255, blue: 24 / 255)
    static let customColor5 = Color(red: 150 / 255, green: 150 / 255, blue: 150 / 255)
    static let customColor6 = Color(red: 133 / 255, green: 133 / 255, blue: 133 / 255)
    static let customColor7 = Color(red: 38 / 255, green: 38 / 255, blue: 38 / 255)
    static let customColor8 = Color(red: 58 / 255, green: 58 / 255, blue: 58 / 255)
    static let customColor9 = Color(red: 0.88, green: 0.61, blue: 0.42)
    static let customColor10 = Color(red: 0.14, green: 0.29, blue: 0.21)
    static let customColor11 = Color(red: 45 / 255, green: 93 / 255, blue: 98 / 255)
}

extension CGColor {
    // Convert CGColor to Hex string with alpha
    func toHexWithAlpha() -> String {
        guard let components = self.components else {
            return "#00000000"
        }

        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)
        let alpha = Int(components[3] * 255.0)

        return String(format: "#%02X%02X%02X%02X", alpha, red, green, blue)
    }
    
    class func fromHexWithAlpha(_ hex: String) -> CGColor? {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var hexValue: UInt64 = 0
        
        let scanner = Scanner(string: hexSanitized)
        scanner.scanHexInt64(&hexValue)
        
        let alpha = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
        let red = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
        let green = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
        let blue = CGFloat(hexValue & 0x000000FF) / 255.0
        
        return CGColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}

extension Color {
    // Convert Color to Hex string with opacity
    func toHexWithOpacity() -> String {
        guard let components = cgColor?.components else {
            return "#00000000"
        }

        let red = Int(components[0] * 255.0)
        let green = Int(components[1] * 255.0)
        let blue = Int(components[2] * 255.0)
        let alpha = Int(components[3] * 255.0)

        return String(format: "#%02X%02X%02X%02X", alpha, red, green, blue)
    }

    init(hexWithOpacity hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var hexValue: UInt64 = 0

        let scanner = Scanner(string: hexSanitized)
        scanner.scanHexInt64(&hexValue)

        let alpha = Double((hexValue & 0xFF000000) >> 24) / 255.0
        let red = Double((hexValue & 0x00FF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x0000FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x000000FF) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension String {
    // Create Color from Hex string with opacity
    func colorFromHexWithOpacity() -> Color {
        var hexSanitized = self.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var hexValue: UInt64 = 0

        let scanner = Scanner(string: hexSanitized)
        scanner.scanHexInt64(&hexValue)

        let alpha = Double((hexValue & 0xFF000000) >> 24) / 255.0
        let red = Double((hexValue & 0x00FF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x0000FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x000000FF) / 255.0

        return Color(red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension String {
    // Convert String to CGFloat
    func toCGFloat() -> CGFloat {
        guard let doubleValue = Double(self) else { return 101 }
        return CGFloat(doubleValue)
    }
}

extension CGFloat {
    // Convert CGFloat to String
    func toString() -> String {
        return String(describing: self)
    }
}
