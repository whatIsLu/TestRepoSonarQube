//
//  TabBarViewModel.swift
//  ClockSnd
//
//  Created by Vlady on 27.03.2024.
//

import Foundation

class TabBarViewModel: ObservableObject {

    @Published var coordinator: MainCoordinator
    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
}
