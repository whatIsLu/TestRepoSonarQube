//
//  DIContainer.swift
//  ClockSnd
//
//  Created by Vlady on 27.03.2024.
//

import Foundation

class DIContainer {
    public let mainCoordinator: MainCoordinator = MainCoordinator()
    public static let shared: DIContainer = DIContainer()
    private init() {}
}
