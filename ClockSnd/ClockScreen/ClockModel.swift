//
//  ClockModel.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 26.08.2023.
//

import Foundation
import SwiftUI
import RealmSwift

class SndClock: Identifiable, Hashable, ObservableObject {
    
    var id = UUID()

    var font: String = ""
    var size: String = "50"
    var spacing: String = "0"
    var fontStyle: String = ""
    var textColor: String = "white"
    var shadow: String = "clean"
    var backgroundColor: String = "black"
    var timeStamp: String = "0"
    var recentTimeStamp: String = "0"

    
    init(id: UUID = UUID(), font: String, size: String, spacing: String, fontStyle: String, textColor: String, shadow: String, backgroundColor: String, timeStamp: String? = nil, recentTimeStamp: String? = nil) {
        self.id = id
        self.font = font
        self.size = size
        self.spacing = spacing
        self.fontStyle = fontStyle
        self.textColor = textColor
        self.shadow = shadow
        self.backgroundColor = backgroundColor
        self.timeStamp = timeStamp ?? Date().timeIntervalSince1970.formatted()
        self.recentTimeStamp = timeStamp ?? Date().timeIntervalSince1970.formatted()
    }

    static func == (lhs: SndClock, rhs: SndClock) -> Bool {
        return lhs.font == rhs.font
        && lhs.fontStyle == rhs.fontStyle
        && lhs.size == rhs.size
        && lhs.spacing == rhs.spacing
        && lhs.textColor == rhs.textColor
        && lhs.backgroundColor == rhs.backgroundColor
        && lhs.shadow == rhs.shadow
//        && lhs.backgroundImage == rhs.backgroundImage
//        &&lhs.backgroundVideoImage == rhs.backgroundVideoImage
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(font)
        hasher.combine(size)
        hasher.combine(spacing)
        hasher.combine(fontStyle)
        hasher.combine(textColor)
        hasher.combine(backgroundColor)
        hasher.combine(shadow)
//        hasher.combine(backgroundImage)
//        hasher.combine(backgroundVideoImage)
    }
}

class SndClockRealm: Object, Identifiable {
    
    @Persisted dynamic var id: UUID
    
    @Persisted var font: String
    @Persisted var size: String
    @Persisted var spacing: String
    @Persisted var fontStyle: String
    @Persisted var textColor: String
    @Persisted var backgroundColor: String
    @Persisted var timeStamp: String
    @Persisted var recentTimeStamp: String
    @Persisted var shadow: String
    
    convenience init(id: UUID, font: String, size: String, spacing: String, fontStyle: String, textColor: String, shadow: String, backgroundColor: String, timeStamp: String? = nil, recentTimeStamp: String? = nil) {
        self.init()
        self.id = id
        self.font = font
        self.size = size
        self.spacing = spacing
        self.fontStyle = fontStyle
        self.textColor = textColor
        self.shadow = shadow
        self.backgroundColor = backgroundColor
        self.timeStamp = timeStamp ?? Date().timeIntervalSince1970.formatted()
        self.recentTimeStamp = timeStamp ?? Date().timeIntervalSince1970.formatted()
    }
    
    static func == (lhs: SndClockRealm, rhs: SndClockRealm) -> Bool {
        return lhs.font == rhs.font
        && lhs.fontStyle == rhs.fontStyle
        && lhs.size == rhs.size
        && lhs.spacing == rhs.spacing
        && lhs.textColor == rhs.textColor
        && lhs.backgroundColor == rhs.backgroundColor
        && lhs.shadow == rhs.shadow
        //        && lhs.backgroundImage == rhs.backgroundImage
        //        &&lhs.backgroundVideoImage == rhs.backgroundVideoImage
    }
}

extension SndClockRealm {

    func toSndClock() -> SndClock {
        return SndClock(font: self.font,
                        size: self.size,
                        spacing: self.spacing,
                        fontStyle: self.fontStyle,
                        textColor: self.textColor,
                        shadow: self.shadow, 
                        backgroundColor: self.backgroundColor,
                        timeStamp: self.timeStamp,
                        recentTimeStamp: self.recentTimeStamp)
    }
}

extension SndClock {

    func toSndClockRealm() -> SndClockRealm {
        let sndClockRealm = SndClockRealm(id: self.id,
                                          font: self.font,
                                          size: self.size,
                                          spacing: self.spacing,
                                          fontStyle: self.fontStyle,
                                          textColor: self.textColor,
                                          shadow: self.shadow,
                                          backgroundColor: self.backgroundColor,
                                          timeStamp: self.timeStamp,
                                          recentTimeStamp: self.recentTimeStamp)
        // Set other properties as needed
        return sndClockRealm
    }
}
