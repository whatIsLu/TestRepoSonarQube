//
//  AccelerometerManager.swift
//  ClockSnd
//
//  Created by Vlady on 31.03.2024.
//

import Foundation
import CoreMotion
import SwiftUI

class AccelerometerManager: ObservableObject {
    private var motionManager = CMMotionManager()
    @Published var acceleration = Acceleration(CMAcceleration(x: 0, y: 0, z: 0))
    private let accelerationChangeThreshold: Double = SndUserDefaults.motionSensitivity
    
    init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdates(to: .main) { [weak self] (data, error) in
            guard let self = self, let acceleration = data?.acceleration else { return }
            self.detectSignificantChange(newAcceleration: Acceleration(acceleration))
        }
    }
    
    private func detectSignificantChange(newAcceleration: Acceleration) {
        print("Change: \(newAcceleration.x)")

        let change = sqrt(
            pow(newAcceleration.x - acceleration.x, 2) +
            pow(newAcceleration.y - acceleration.y, 2) +
            pow(newAcceleration.z - acceleration.z, 2)
        )
        if change > accelerationChangeThreshold {
            DispatchQueue.main.async {
                self.acceleration = newAcceleration
                print("Done: \(newAcceleration.x)")

            }
        }
    }
}

struct Acceleration: Equatable {
    let x: Double
    let y: Double
    let z: Double

    init(_ acceleration: CMAcceleration) {
        self.x = acceleration.x
        self.y = acceleration.y
        self.z = acceleration.z
    }
}
