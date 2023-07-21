//
//  Persisted.swift
//  Overreacted
//
//  Created by Ali Saeedifar on 7/20/23.
//

import Foundation

@propertyWrapper struct Persisted<Value: Codable> {
    var wrappedValue: Value {
        get {
            if let data = storage.value(forKey: key) as? Data,
               let value = try? JSONDecoder().decode(Value.self, from: data) {
                return value
            }
            return defaultValue
        }
        set {
            if let optional = newValue as? AnyOptional, optional.isNil {
                storage.removeObject(forKey: key)
            } else {
                if let encoded = try? JSONEncoder().encode(newValue) {
                    storage.setValue(encoded, forKey: key)
                }
            }
        }
    }
    
    private let key: String
    private let defaultValue: Value
    private let storage: UserDefaults
    
    init(wrappedValue defaultValue: Value,
         key: String,
         storage: UserDefaults = .standard) {
        self.defaultValue = defaultValue
        self.key = key
        self.storage = storage
    }
}


extension Persisted where Value: ExpressibleByNilLiteral {
    init(key: String, storage: UserDefaults = .standard) {
        self.init(wrappedValue: nil, key: key, storage: storage)
    }
}
