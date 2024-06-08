//
//  UserDefaultManger.swift
//  Damagochi
//
//  Created by 유철원 on 6/7/24.
//

import Foundation


struct UserDefaultsManager {
    
    static var userKey = "nowUser"
    static var damagochiKey = "DamagochiList"
    
    @UserDefaultWrapper(key: "nowUser", defaultValue: nil)
    static var nowUser: User?
    
    @UserDefaultWrapper(key: "DamagochiList", defaultValue: nil)
    static var damagochiList: [Damagochi]?
    
    static func removeValue(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}


@propertyWrapper
struct UserDefaultWrapper<T: Codable> {
    private let key: String
    private let defaultValue: T?
    
    init(key: String, defaultValue: T?) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T? {
        get {
            if let savedData = UserDefaults.standard.object(forKey: key) as? Data {
                let decoder = JSONDecoder()
                if let lodedObejct = try? decoder.decode(T.self, from: savedData) {
                    return lodedObejct
                }
            }
            return defaultValue
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.setValue(encoded, forKey: key)
            }
        }
    }
}
