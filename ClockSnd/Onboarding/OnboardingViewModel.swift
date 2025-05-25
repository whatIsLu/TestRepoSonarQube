//
//  OnboardingViewModel.swift
//  ClockSnd
//
//  Created by Vlady on 28.03.2024.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var coordinator: MainCoordinator

    init(coordinator: MainCoordinator) {
        self.coordinator = coordinator
    }
    
    func endOnboarding() {
        SndUserDefaults.onboarding = true
        coordinator.setRootView(to: .basic)
    }
}
