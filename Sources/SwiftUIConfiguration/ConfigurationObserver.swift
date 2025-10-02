//
//  ConfigurationObserver.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import SwiftUI
import Configuration

/// Internal storage for configuration values.
///
/// This class manages the cached value and subscription lifecycle for a configuration property.
@MainActor
final class _ConfigurationValueStorage<T: Sendable>: ObservableObject {
    /// The cached configuration value.
    @Published var cachedResult: T?
    
    /// The timestamp of the last successful update.
    var lastUpdateDate: Date?
    
    /// Subscribes to configuration updates.
    ///
    /// - Parameter updatesHandler: The async sequence of configuration updates.
    nonisolated func subscribe(updatesHandler: ConfigUpdatesAsyncSequence<T, Never>) async {
        for await update in updatesHandler {
            Task { @MainActor in
                self.cachedResult = update
                self.lastUpdateDate = Date()
            }
        }
    }
}

