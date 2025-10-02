//
//  PropertyWrapperTests.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import Testing
@testable import SwiftUIConfiguration

// MARK: - Configuration Property Wrapper Tests

@Suite("Configuration Property Wrapper", .tags(.propertyWrapper))
struct PropertyWrapperTests {
    
    @Test("String configuration key has correct default")
    func stringKeyDefault() {
        #expect(TestStringKey.defaultValue == "default")
    }
    
    @Test("Int configuration key has correct default")
    func intKeyDefault() {
        #expect(TestIntKey.defaultValue == 42)
    }
    
    @Test("Double configuration key has correct default")
    func doubleKeyDefault() {
        #expect(TestDoubleKey.defaultValue == 3.14)
    }
    
    @Test("Bool configuration key has correct default")
    func boolKeyDefault() {
        #expect(TestBoolKey.defaultValue == false)
    }
    
    @Test("Optional configuration keys support nil")
    func optionalConfigurationKeys() {
        #expect(TestOptionalStringKey.defaultValue == nil)
        #expect(TestOptionalIntKey.defaultValue == nil)
    }
}

