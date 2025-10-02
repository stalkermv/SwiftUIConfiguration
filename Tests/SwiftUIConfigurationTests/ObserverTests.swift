//
//  ObserverTests.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import Testing
import Foundation
@testable import SwiftUIConfiguration

// MARK: - Configuration Value Storage Tests

@Suite("Configuration Value Storage Lifecycle", .tags(.observer)) @MainActor
struct ValueStorageLifecycleTests {
    
    @Test("Storage initializes with nil cached result")
    func initialState() {
        let storage = _ConfigurationValueStorage<String>()
        #expect(storage.cachedResult == nil)
        #expect(storage.lastUpdateDate == nil)
    }
    
    @Test("Storage updates cached result with string")
    func cachedResultUpdateString() {
        let storage = _ConfigurationValueStorage<String>()
        #expect(storage.cachedResult == nil)
        
        storage.cachedResult = "test"
        #expect(storage.cachedResult == "test")
    }
    
    @Test("Storage updates cached result with int")
    func cachedResultUpdateInt() {
        let storage = _ConfigurationValueStorage<Int>()
        #expect(storage.cachedResult == nil)
        
        storage.cachedResult = 42
        #expect(storage.cachedResult == 42)
    }
    
    @Test("Storage updates cached result with double")
    func cachedResultUpdateDouble() {
        let storage = _ConfigurationValueStorage<Double>()
        #expect(storage.cachedResult == nil)
        
        storage.cachedResult = 3.14
        #expect(storage.cachedResult == 3.14)
    }
    
    @Test("Storage updates cached result with bool")
    func cachedResultUpdateBool() {
        let storage = _ConfigurationValueStorage<Bool>()
        #expect(storage.cachedResult == nil)
        
        storage.cachedResult = true
        #expect(storage.cachedResult == true)
    }
    
    @Test("Storage tracks last update date")
    func lastUpdateDateTracking() {
        let storage = _ConfigurationValueStorage<String>()
        #expect(storage.lastUpdateDate == nil)
        
        let now = Date()
        storage.cachedResult = "updated"
        storage.lastUpdateDate = now
        
        #expect(storage.lastUpdateDate == now)
    }
}

