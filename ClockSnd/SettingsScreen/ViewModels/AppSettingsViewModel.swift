//
//  AppSettingsViewModel.swift
//  ClockSnd
//
//  Created by Vlady on 31.03.2024.
//

import Foundation
import SwiftUI

class AppSettingsViewModel: ObservableObject {
    @Published var coordinator: MainCoordinator

    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
}
