//
//  ClockCreatorViewModel.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 27.08.2023.
//

import Foundation
import CoreGraphics
import SwiftUI

enum CustomizerSelector {
    case color
    case size
    case spacing
    case font
    case save
    case fontStyle
}

enum PickerColor {
    case background
    case clock
    case shadow
}


class ClockCreatorViewModel: ObservableObject {
    @Published var previewClock: ClockView?
    @Published var backgroundColor: CGColor = .init(red: 240/255, green: 230/255, blue: 220/255, alpha: 1)
    @Published var fontColor: CGColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    @Published var shadow: CGColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
    @Published var font: Font.FontFamily = .nunito
    @Published var fontStyle: Font.FontStyle = .regular
    @Published var size: Int = 100
    @Published var spacing: Int = 5
    @Published var selectedPicker: PickerColor = .background
    @Published var selectedCustomizer: CustomizerSelector = .color
    
    let clockManager: GlobalClockManager = GlobalClockManager.shared

    init(previewClock: ClockView? = nil) {
        self.previewClock = previewClock
    }
    
    func saveClock() {
        let newClock = SndClock(font: font.rawValue, size: String(size), spacing: String(spacing), fontStyle: fontStyle.rawValue, textColor: fontColor.toHexWithAlpha(), shadow: shadow.toHexWithAlpha(), backgroundColor: backgroundColor.toHexWithAlpha())
        clockManager.realmManager.addClock(clock: newClock, config: .savedClocks)
        clockManager.syncClocksWithDB()
    }
}

extension CGColor {
    func hexString() -> String {
        let numComponents = self.numberOfComponents
        let components = self.components
        var r, g, b: CGFloat
        
        if numComponents == 4 {
            r = components?[0] ?? 0
            g = components?[1] ?? 0
            b = components?[2] ?? 0
        } else {
            r = components?[0] ?? 0
            g = components?[0] ?? 0
            b = components?[0] ?? 0
        }
        
        return String(format: "%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
    }
}
