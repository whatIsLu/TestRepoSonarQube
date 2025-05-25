//
//  AboutViewModel.swift
//  ClockSnd
//
//  Created by Vlady on 31.03.2024.
//

import Foundation

class AboutViewModel: ObservableObject {
    @Published var coordinator: MainCoordinator

    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
}
