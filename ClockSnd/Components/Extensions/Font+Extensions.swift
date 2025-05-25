//
//  Font+Extensions.swift
//  ClockSnd
//
//  Created by Vlady on 26.08.2023.
//

import Foundation
import SwiftUI

extension Font {
    enum FontFamily: String {
        case rubikScribble = "RubikScribble"
        case merriweather = "Merriweather"
        case ubuntu = "Ubuntu"
        case workSans = "WorkSans"
        case workbench = "Workbench"
        case bebasNeue = "BebasNeue"
        case abel = "Abel"
        case bitter = "Bitter"
        case eduNSWACTFoundation = "EduNSWACTFoundation"
        case zillaSlab = "ZillaSlab"
        case abrilFatface = "AbrilFatface"
        case orbitron = "Orbitron"
        case acme = "Acme"
        case concertOne = "ConcertOne"
        case nunito = "Nunito"
        case jost = "Jost"
        case roboto = "Roboto"
        // Add more font families as needed
        
        var intValue: Int {
            switch self {
            case .jost: return 0
            case .nunito: return 1
            case .roboto: return 2
            case .rubikScribble: return 3
            case .merriweather: return 4
            case .ubuntu: return 5
            case .workSans: return 6
            case .workbench: return 7
            case .bebasNeue: return 8
            case .abel: return 9
            case .bitter: return 10
            case .eduNSWACTFoundation: return 11
            case .zillaSlab: return 12
            case .abrilFatface: return 14
            case .orbitron: return 15
            case .acme: return 16
            case .concertOne: return 17
            }
        }
        
        static var allFontFamilies: [FontFamily] {
            return [.jost, .nunito, .roboto, .rubikScribble, .merriweather, .ubuntu, .workSans, .workbench, .bebasNeue, .abel, .bitter, .eduNSWACTFoundation, .zillaSlab, .abrilFatface, .orbitron, .acme, .concertOne]
        }
    }

    enum FontStyle: String {
        case black
        case blackItalic = "blackitalic"
        case bold
        case boldItalic = "bolditalic"
        case extraBold = "extrabold"
        case extraBoldItalic = "extrabolditalic"
        case extraLight = "extralight"
        case extraLightItalic = "extralightitalic"
        case italic
        case light
        case lightItalic = "lightitalic"
        case medium
        case mediumItalic = "mediumitalic"
        case regular
        case semiBold = "semibold"
        case semiBoldItalic = "semibolditalic"
        
        var description: String {
            switch self {
            case .black: "Black"
            case .blackItalic: "Black Italic"
            case .bold: "Bold"
            case .boldItalic: "Bold Italic"
            case .extraBold: "Extra Bold"
            case .extraBoldItalic: "Extra Bold Italic"
            case .extraLight: "Extra Light"
            case .extraLightItalic: "Extra Light Italic"
            case .italic: "Italic"
            case .light: "Light"
            case .lightItalic: "Light Italic"
            case .medium: "Medium"
            case .mediumItalic: "Medium Italic"
            case .regular: "Regular"
            case .semiBold: "Semibold"
            case .semiBoldItalic: "Semi Bold Italic"
            }
        }
        static var allFontFamilies: [FontStyle] {
            return [.black, .blackItalic, .bold, .boldItalic, .extraBold, .extraBoldItalic, .extraLight, .extraLightItalic, .italic, .light, .lightItalic, .medium, .mediumItalic, .regular, .semiBold, .semiBoldItalic]
        }
    }

    static func customFont(family: FontFamily, style: FontStyle, size: CGFloat) -> Font {
        let fontName = "\(family.rawValue)-\(style.rawValue.capitalized)"
        if let font = UIFont(name: fontName, size: size) {
            return Font(font)
        } else {
            return Font.system(size: size)
        }
    }
}
