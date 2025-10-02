//
//  ConfigReaderTests.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import Testing
import Configuration
@testable import SwiftUIConfiguration

// MARK: - ConfigReader Basic Functionality Tests

@Suite("ConfigReader Basic Operations", .tags(.providers))
struct ConfigReaderBasicTests {
    
    let provider = InMemoryProvider(values: [
        "TEST_STRING": "configured",
        "TEST_INT": 100,
        "TEST_DOUBLE": 2.71,
        "TEST_BOOL": true
    ])
    
    @Test("Reading configured string value")
    func readStringValue() {
        let configReader = ConfigReader(provider: provider)
        let value = configReader.string(forKey: "TEST_STRING", default: "default")
        #expect(value == "configured")
    }
    
    @Test("Reading configured int value")
    func readIntValue() {
        let configReader = ConfigReader(provider: provider)
        let value = configReader.int(forKey: "TEST_INT", default: 0)
        #expect(value == 100)
    }
    
    @Test("Reading configured double value")
    func readDoubleValue() {
        let configReader = ConfigReader(provider: provider)
        let value = configReader.double(forKey: "TEST_DOUBLE", default: 0.0)
        #expect(value == 2.71)
    }
    
    @Test("Reading configured bool value")
    func readBoolValue() {
        let configReader = ConfigReader(provider: provider)
        let value = configReader.bool(forKey: "TEST_BOOL", default: false)
        #expect(value == true)
    }
    
    @Test("Missing string key returns default")
    func missingStringKey() {
        let configReader = TestHelpers.createConfigReader(values: [:])
        let value = configReader.string(forKey: "MISSING", default: "fallback")
        #expect(value == "fallback")
    }
    
    @Test("Missing int key returns default")
    func missingIntKey() {
        let configReader = TestHelpers.createConfigReader(values: [:])
        let value = configReader.int(forKey: "MISSING", default: 0)
        #expect(value == 0)
    }
    
    @Test("Missing double key returns default")
    func missingDoubleKey() {
        let configReader = TestHelpers.createConfigReader(values: [:])
        let value = configReader.double(forKey: "MISSING", default: 0.0)
        #expect(value == 0.0)
    }
    
    @Test("Missing bool key returns default")
    func missingBoolKey() {
        let configReader = TestHelpers.createConfigReader(values: [:])
        let value = configReader.bool(forKey: "MISSING", default: false)
        #expect(value == false)
    }
}

// MARK: - Provider Hierarchy Tests

@Suite("Provider Hierarchy", .tags(.providers))
struct ProviderHierarchyTests {
    
    @Test("First provider takes precedence")
    func firstProviderPrecedence() {
        let reader = TestHelpers.createMultiProviderReader(
            primary: ["KEY": "primary"],
            secondary: ["KEY": "secondary"]
        )
        let value = reader.string(forKey: "KEY", default: "default")
        #expect(value == "primary")
    }
    
    @Test("Falls back to second provider when key missing in first")
    func secondProviderFallback() {
        let reader = TestHelpers.createMultiProviderReader(
            primary: [:],
            secondary: ["KEY": "secondary"]
        )
        let value = reader.string(forKey: "KEY", default: "default")
        #expect(value == "secondary")
    }
    
    @Test("Uses default when key missing in all providers")
    func defaultWhenAllProvidersMissing() {
        let reader = TestHelpers.createMultiProviderReader(
            primary: [:],
            secondary: [:]
        )
        let value = reader.string(forKey: "KEY", default: "default")
        #expect(value == "default")
    }
}

// MARK: - Secret Handling Tests

@Suite("Secret Value Handling", .tags(.security))
struct SecretHandlingTests {
    
    @Test("Secret values can be read correctly")
    func readSecretValue() {
        let reader = TestHelpers.createConfigReader(values: [
            "SECRET": "top-secret"
        ])
        
        let value = reader.string(
            forKey: "SECRET",
            isSecret: true,
            default: "default"
        )
        
        #expect(value == "top-secret")
    }
    
    @Test("Secret key configuration")
    func secretKeyConfiguration() {
        #expect(TestSecretKey.isSecret == true)
        #expect(TestSecretKey.name == "TEST_SECRET")
        #expect(TestSecretKey.defaultValue == "secret")
    }
    
    @Test("Non-secret keys are properly marked")
    func nonSecretKeys() {
        #expect(TestStringKey.isSecret == false)
        #expect(TestIntKey.isSecret == false)
    }
}

