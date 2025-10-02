//
//  EnvironmentValues+ConfigurationReader.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import SwiftUI
import Configuration

extension View {
    /// Sets the configuration reader for this view and its children.
    ///
    /// Use this modifier to provide a `ConfigReader` to the view hierarchy:
    ///
    /// ```swift
    /// ContentView()
    ///     .configurationReader(
    ///         ConfigReader(providers: [
    ///             EnvironmentVariablesProvider(),
    ///             InMemoryProvider(values: ["PORT": 8080])
    ///         ])
    ///     )
    /// ```
    ///
    /// All `@Configuration` property wrappers within the view hierarchy will use this reader.
    ///
    /// - Parameter configReader: The configuration reader instance to use.
    /// - Returns: A view with the configuration reader set in its environment.
    public func configurationReader(_ configReader: ConfigReader) -> some View {
        environment(\.configReader, configReader)
    }
}

extension EnvironmentValues {
    /// The configuration reader used by `@Configuration` property wrappers.
    private struct ConfigReaderKey: EnvironmentKey {
        static let defaultValue: ConfigReader = ConfigReader(provider: InMemoryProvider(values: [:]))
    }
    
    /// The configuration reader from the environment.
    ///
    /// This value is automatically set when using the `.configurationReader(_:)` modifier.
    var configReader: ConfigReader {
        get { self[ConfigReaderKey.self] }
        set { self[ConfigReaderKey.self] = newValue }
    }
}

