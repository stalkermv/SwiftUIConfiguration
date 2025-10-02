//
//  ConfigurationKeyTests.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import Testing
import SwiftUI
import Configuration
@testable import SwiftUIConfiguration

// MARK: - ConfigurationKey Tests

@Suite("ConfigurationKey Protocol", .tags(.configurationKey))
struct ConfigurationKeyTests {
    
    @Test("String key has correct name and default")
    func stringKeyProperties() {
        #expect(TestStringKey.name == "TEST_STRING")
        #expect(TestStringKey.defaultValue == "default")
    }
    
    @Test("Int key has correct name and default")
    func intKeyProperties() {
        #expect(TestIntKey.name == "TEST_INT")
        #expect(TestIntKey.defaultValue == 42)
    }
    
    @Test("Double key has correct name and default")
    func doubleKeyProperties() {
        #expect(TestDoubleKey.name == "TEST_DOUBLE")
        #expect(TestDoubleKey.defaultValue == 3.14)
    }
    
    @Test("Bool key has correct name and default")
    func boolKeyProperties() {
        #expect(TestBoolKey.name == "TEST_BOOL")
        #expect(TestBoolKey.defaultValue == false)
    }
    
    @Test("isSecret defaults to false")
    func isSecretDefaultValue() {
        #expect(TestStringKey.isSecret == false)
        #expect(TestIntKey.isSecret == false)
        #expect(TestDoubleKey.isSecret == false)
    }
    
    @Test("Secret key is marked correctly", .tags(.security))
    func secretKeyMarking() {
        #expect(TestSecretKey.isSecret == true)
        #expect(TestSecretKey.name == "TEST_SECRET")
    }
    
    @Test("makeContext returns empty dictionary by default")
    func defaultContextIsEmpty() {
        let context = TestStringKey.makeContext(from: EnvironmentValues())
        #expect(context.isEmpty)
        #expect(context.count == 0)
    }
}

// MARK: - Optional and Array Types Tests

@Suite("Type Support", .tags(.types))
struct TypeSupportTests {
    
    @Test("Optional string key supports nil default")
    func optionalStringDefault() {
        #expect(TestOptionalStringKey.defaultValue == nil)
    }
    
    @Test("Optional int key supports nil default")
    func optionalIntDefault() {
        #expect(TestOptionalIntKey.defaultValue == nil)
    }
    
    @Test("String array key has empty default")
    func stringArrayDefault() {
        #expect(TestStringArrayKey.defaultValue.isEmpty)
    }
    
    @Test("Int array key has empty default")
    func intArrayDefault() {
        #expect(TestIntArrayKey.defaultValue.isEmpty)
    }
    
    @Test("Double array key has empty default")
    func doubleArrayDefault() {
        #expect(TestDoubleArrayKey.defaultValue.isEmpty)
    }
    
    @Test("Bool array key has empty default")
    func boolArrayDefault() {
        #expect(TestBoolArrayKey.defaultValue.isEmpty)
    }
}

