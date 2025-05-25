//
//  DisableModifier.swift
//  ClockSnd
//
//  Created by Vlady on 31.03.2024.
//

import Foundation
import SwiftUI

struct CustomDisabledModifier: ViewModifier {
    var isDisabled: Bool
    
    func body(content: Content) -> some View {
        content
            .opacity(isDisabled ? 0.5 : 1) // Example styling for disabled state
            .disabled(isDisabled)
    }
}

extension View {
    func sndDisabled(_ isDisabled: Bool) -> some View {
        self.modifier(CustomDisabledModifier(isDisabled: isDisabled))
    }
}
