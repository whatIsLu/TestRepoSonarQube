//
//  ClockViewModel.swift
//  ClockSnd
//
//  Created by Vlady on 27.03.2024.
//

import Foundation

class ClockViewModel: ObservableObject {
    @Published var coordinator: MainCoordinator
    @Published var clockModel: SndClock

    init(clockModel: SndClock, coordinator: MainCoordinator) {
        self.clockModel = clockModel
        self.coordinator = coordinator
    }
}
