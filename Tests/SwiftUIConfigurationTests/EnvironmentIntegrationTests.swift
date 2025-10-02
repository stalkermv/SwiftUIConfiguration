//
//  EnvironmentIntegrationTests.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import Testing
import SwiftUI
@testable import SwiftUIConfiguration

// MARK: - Environment Integration Tests

@Suite("SwiftUI Environment Integration", .tags(.environment, .integration))
struct EnvironmentIntegrationTests {
    
    @Test("Default ConfigReader exists in EnvironmentValues")
    func defaultConfigReaderExists() {
        let envValues = EnvironmentValues()
        let reader = envValues.configReader
        
        // Verify it's a valid reader by using it
        let value = reader.string(forKey: "TEST", default: "works")
        #expect(value == "works")
    }
    
    @Test("ConfigReader can be set in environment")
    func customConfigReaderInEnvironment() {
        var envValues = EnvironmentValues()
        let customReader = TestHelpers.createConfigReader(values: [
            "CUSTOM": "value"
        ])
        
        envValues.configReader = customReader
        
        let value = envValues.configReader.string(forKey: "CUSTOM", default: "default")
        #expect(value == "value")
    }
}

