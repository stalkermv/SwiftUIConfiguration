//
//  Configuration.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import SwiftUI
import Configuration

/// A property wrapper that reads configuration values from the environment.
///
/// Use `@Configuration` to access configuration values in your SwiftUI views:
/// ```swift
/// struct ContentView: View {
///     @Configuration(.apiEndpoint) var endpoint: String
///
///     var body: some View {
///         Text("Endpoint: \(endpoint)")
///     }
/// }
/// ```
/// Access additional metadata using the projected value:
/// ```swift
/// struct StatusView: View {
///     @Configuration(.apiKey) var apiKey
///
///     var body: some View {
///         if let error = $apiKey.error {
///             Text("Error: \(error.localizedDescription)")
///         }
///     }
/// }
/// ```
@propertyWrapper @MainActor
public struct Configuration<T: Sendable> : DynamicProperty {
    // MARK: - Internal Type Aliases
    
    internal typealias _UpdateHandler = @Sendable (ConfigUpdatesAsyncSequence<T, Never>) async throws -> Void
    internal typealias _Context = [String: ConfigContextValue]
    internal typealias _ValueProvider = (ConfigReader, _Context, _UpdateHandler) async throws -> Void
    
    final class _State {
        var isListeningForUpdates: Bool = false
    }
    
    // MARK: - Public Type Aliases
    
    public typealias ContextProvider = (EnvironmentValues) -> [String: ConfigContextValue]
    
    // MARK: - Environment
    
    @Environment(\.self) private var environment
    @Environment(\.configReader) private var configReader
    
    // MARK: - Private Properties
    
    private let key: String
    private let isSecret: Bool
    private let defaultValue: T
    private let context: ContextProvider?
    private var value: _ValueProvider
    
    private let state = _State()
    @State private var isLoading = false
    @State public var error: Error?
    @StateObject private var storage = _ConfigurationValueStorage<T>()
    
    
    // MARK: - Public Interface
    
    /// The current configuration value.
    public var wrappedValue: T {
        storage.cachedResult ?? defaultValue
    }
    
    /// Projection that provides access to metadata about the configuration value.
    public struct Projection {
        /// The current configuration value.
        public let value: T
        
        /// The current error, if any occurred while fetching the configuration.
        public let error: Error?
        
        /// Whether the configuration value is currently being loaded.
        public let isLoading: Bool
        
        /// The timestamp of the last successful update.
        public let lastUpdate: Date?
    }
    
    /// Provides access to configuration metadata through the projected value.
    ///
    /// Access this using the `$` prefix:
    /// ```swift
    /// @Configuration(.apiKey) var apiKey
    /// if let error = $apiKey.error { ... }
    /// ```
    public var projectedValue: Projection {
        Projection(
            value: wrappedValue,
            error: error,
            isLoading: isLoading,
            lastUpdate: storage.lastUpdateDate
        )
    }
    
    // MARK: - Initialization
    
    internal init(
        _ key: String,
        isSecret: Bool = false,
        defaultValue: T,
        context: ContextProvider?,
        value: @escaping _ValueProvider
    ) {
        self.key = key
        self.isSecret = isSecret
        self.defaultValue = defaultValue
        self.context = context
        self.value = value
    }
    
    nonisolated public func update() {
        MainActor.assumeIsolated {
            guard !state.isListeningForUpdates else { return }
            state.isListeningForUpdates = true
            
            Task {
                do {
                    try await self.listenForUpdates()
                } catch {
                    self.error = error
                    self.state.isListeningForUpdates = false
                }
            }
        }
    }
    
    private func listenForUpdates() async throws {
        let context = context?(environment) ?? [:]
        
        let loadingTask = Task { @MainActor in
            try await Task.sleep(for: .milliseconds(100))
            isLoading = true
        }
        
        try await value(configReader, context) { updates in
            loadingTask.cancel()
            Task { @MainActor in
                isLoading = false
            }
            await storage.subscribe(updatesHandler: updates)
        }
    }
}
