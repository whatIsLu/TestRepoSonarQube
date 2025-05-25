//
//  RealmData.swift
//  ClockSnd
//
//  Created by Vlady on 28.11.2023.
//

import Foundation
import RealmSwift


enum ConfigsRealm {
    case recentClocks
    case savedClocks
    
    var url: Realm.Configuration {
        switch self {
        case .recentClocks:
            Realm.Configuration(fileURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("recentClocks"))
            
        case .savedClocks:
            Realm.Configuration(fileURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("savedClocks"))
        }
    }
}

enum SortByTime {
    case recentTime
    case timeOfCreation
}

class RealmManager {
    static let shared: RealmManager = RealmManager()
    private init() {}
    
    func getAllObjects(config: ConfigsRealm, sortBy: SortByTime = .recentTime) -> [SndClock] {
        let realm = try! Realm(configuration: config.url)
        if sortBy == .recentTime {
            return realm.objects(SndClockRealm.self).sorted { $0.recentTimeStamp < $1.recentTimeStamp }.map { $0.toSndClock() }
        } else {
            return realm.objects(SndClockRealm.self).sorted { $0.timeStamp < $1.timeStamp }.map { $0.toSndClock() }
        }
    }
        
    func addClock(clock: SndClock, config: ConfigsRealm) {
        let realm = try! Realm(configuration: config.url)
        let objects = realm.objects(SndClockRealm.self)
        if let object = objects.first(where: { $0.toSndClock() == clock }) {
            try! realm.write {
                object.recentTimeStamp = Date().timeIntervalSince1970.formatted()
            }
        } else {
            try! realm.write {
                realm.add(clock.toSndClockRealm())
            }
        }
    }
    
    func deleteClock(clock: SndClock, config: ConfigsRealm) {
        let realm = try! Realm(configuration: config.url)
        let objects = realm.objects(SndClockRealm.self)

        if let currentObject = objects.first(where: { $0.toSndClock() == clock }) {
            try! realm.write {
                realm.delete(currentObject)
            }
        }
    }
}
