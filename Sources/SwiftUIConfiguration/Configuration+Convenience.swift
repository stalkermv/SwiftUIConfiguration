//
//  Configuration+Convenience.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import SwiftUI
import Configuration

extension Configuration where T: ExpressibleByConfigString {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == T {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchString(
                forKey: K.name,
                context: $1,
                as: T.self,
                isSecret: K.isSecret,
                default: K.defaultValue,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T: RawRepresentable<String> {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == T {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchString(
                forKey: K.name,
                context: $1,
                as: T.self,
                isSecret: K.isSecret,
                default: K.defaultValue,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == Int {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == Int {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchInt(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                default: K.defaultValue,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == Double {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == Double {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchDouble(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                default: K.defaultValue,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == Bool {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == Bool {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchBool(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                default: K.defaultValue,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == String {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == String {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchString(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                default: K.defaultValue,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == [Int] {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == [Int] {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchIntArray(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                default: K.defaultValue,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == [String] {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == [String] {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchStringArray(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                default: K.defaultValue,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == [Double] {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == [Double] {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchDoubleArray(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                default: K.defaultValue,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == [Bool] {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == [Bool] {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchBoolArray(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                default: K.defaultValue,
                updatesHandler: $2
            )
        }
    }
}

// MARK: - Optional types support

extension Configuration where T == String? {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == String? {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) {
            try await $0.watchString(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == Int? {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == Int? {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) { 
            try await $0.watchInt(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == Double? {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == Double? {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) { 
            try await $0.watchDouble(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == Bool? {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == Bool? {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) { 
            try await $0.watchBool(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == [String]? {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == [String]? {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) { 
            try await $0.watchStringArray(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                updatesHandler: $2
            ) 
        }
    }
}

extension Configuration where T == [Int]? {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == [Int]? {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) { 
            try await $0.watchIntArray(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == [Double]? {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == [Double]? {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) { 
            try await $0.watchDoubleArray(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                updatesHandler: $2
            )
        }
    }
}

extension Configuration where T == [Bool]? {
    public init<K: ConfigurationKey>(_ key: K, context: ContextProvider? = nil)
    where K.Value == [Bool]? {
        self.init(K.name, isSecret: K.isSecret, defaultValue: K.defaultValue, context: context) { 
            try await $0.watchBoolArray(
                forKey: K.name,
                context: $1,
                isSecret: K.isSecret,
                updatesHandler: $2
            )
        }
    }
}
