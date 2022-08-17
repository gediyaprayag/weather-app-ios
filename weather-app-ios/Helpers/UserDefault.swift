//
//  UserDefault.swift
//  weather-app-ios
//
//  Created by Prayag Gediya on 16/08/22.
//

import Foundation
import Combine

@propertyWrapper
struct UserDefault<T: Codable> {
    let key: String
    let defaultValue: T

    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    var wrappedValue: T {
        get {
            if let value = UserDefaults.standard.object(forKey: key) as? Data {
                do {
                    let value = try JSONDecoder().decode(T.self, from: value)
                    return value
                } catch let parseError {
                    print(parseError)
                    return defaultValue
                }
            }
            return defaultValue
        } set {
            if let encoded = try? JSONEncoder().encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: key)
                UserDefaults.standard.synchronize()
            }
        }
    }
}
