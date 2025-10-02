//
//  TestUtilities.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import Testing
import SwiftUI
import Configuration
@testable import SwiftUIConfiguration

// MARK: - Test Tags

extension Tag {
    @Tag static var configurationKey: Self
    @Tag static var propertyWrapper: Self
    @Tag static var providers: Self
    @Tag static var types: Self
    @Tag static var security: Self
    @Tag static var environment: Self
    @Tag static var observer: Self
    @Tag static var integration: Self
}

// MARK: - Test Configuration Keys

struct TestStringKey: ConfigurationKey {
    static let name = "TEST_STRING"
    static let defaultValue = "default"
}

struct TestIntKey: ConfigurationKey {
    static let name = "TEST_INT"
    static let defaultValue = 42
}

struct TestDoubleKey: ConfigurationKey {
    static let name = "TEST_DOUBLE"
    static let defaultValue = 3.14
}

struct TestBoolKey: ConfigurationKey {
    static let name = "TEST_BOOL"
    static let defaultValue = false
}

struct TestOptionalStringKey: ConfigurationKey {
    static let name = "TEST_OPTIONAL_STRING"
    static let defaultValue: String? = nil
}

struct TestOptionalIntKey: ConfigurationKey {
    static let name = "TEST_OPTIONAL_INT"
    static let defaultValue: Int? = nil
}

struct TestStringArrayKey: ConfigurationKey {
    static let name = "TEST_STRING_ARRAY"
    static let defaultValue: [String] = []
}

struct TestIntArrayKey: ConfigurationKey {
    static let name = "TEST_INT_ARRAY"
    static let defaultValue: [Int] = []
}

struct TestDoubleArrayKey: ConfigurationKey {
    static let name = "TEST_DOUBLE_ARRAY"
    static let defaultValue: [Double] = []
}

struct TestBoolArrayKey: ConfigurationKey {
    static let name = "TEST_BOOL_ARRAY"
    static let defaultValue: [Bool] = []
}

struct TestSecretKey: ConfigurationKey {
    static let name = "TEST_SECRET"
    static let defaultValue = "secret"
    static let isSecret = true
}

// MARK: - Test Helpers

enum TestHelpers {
    static func createInMemoryProvider(values: [String: ConfigValue]) -> InMemoryProvider {
        InMemoryProvider(values: values)
    }
    
    static func createConfigReader(values: [String: ConfigValue]) -> ConfigReader {
        ConfigReader(provider: createInMemoryProvider(values: values))
    }
    
    static func createMultiProviderReader(
        primary: [String: ConfigValue],
        secondary: [String: ConfigValue]
    ) -> ConfigReader {
        ConfigReader(providers: [
            createInMemoryProvider(values: primary),
            createInMemoryProvider(values: secondary)
        ])
    }
}

