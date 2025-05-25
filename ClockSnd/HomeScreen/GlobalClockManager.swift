//
//  GlobalClockManager.swift
//  ClockSnd
//
//  Created by Vladyslav Romaniv on 26.08.2023.
//

import Foundation
import SwiftUI
import CoreData
import RealmSwift

class GlobalClockManager: ObservableObject {
    @Published var arrayOfClockConfigurations: [SndClock] = []
    @Published var savedClocks: [SndClock] = []
    let realmManager: RealmManager = RealmManager.shared
    
    var clockView: ClockView? {
        didSet {
            if let newClockSet = clockView?.viewModel.clockModel {
                if arrayOfClockConfigurations.count > 9,
                   let currentObject = realmManager.getAllObjects(config: .recentClocks).min(by: { $0.recentTimeStamp < $1.recentTimeStamp }) {
                    realmManager.deleteClock(clock: currentObject, config: .recentClocks)
                }
                
                realmManager.addClock(clock: newClockSet, config: .recentClocks)
                syncClocksWithDB()
            }
        }
    }
    
    public static let shared: GlobalClockManager = GlobalClockManager()
    
    private init() {
        syncClocksWithDB()
    }
    
    public func syncClocksWithDB() {
        arrayOfClockConfigurations = realmManager.getAllObjects(config: .recentClocks)
        savedClocks = realmManager.getAllObjects(config: .savedClocks, sortBy: .timeOfCreation)
    }
    
}
