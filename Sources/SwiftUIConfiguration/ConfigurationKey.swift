//
//  ConfigurationKey.swift
//  SwiftUIConfiguration
//
//  Created by Valeriy Malishevskyi on 02.10.2025.
//

import SwiftUI
import Configuration

/// A type that represents a configuration key.
///
/// Conform to this protocol to define configuration keys for your application:
///
/// ```swift
/// struct APIEndpointKey: ConfigurationKey {
///     static let name = "API_ENDPOINT"
///     static let defaultValue = "https://api.example.com"
/// }
/// ```
///
/// For convenience, create a static property:
///
/// ```swift
/// extension ConfigurationKey where Self == APIEndpointKey {
///     static var apiEndpoint: Self { .init() }
/// }
///
/// // Usage
/// @Configuration(.apiEndpoint) var endpoint
/// ```
public protocol ConfigurationKey {
    /// The context type for configuration reading.
    typealias Context = [String: ConfigContextValue]
    
    /// The type of value this configuration key represents.
    associatedtype Value
    
    /// The string key used to look up the configuration value.
    static var name: String { get }
    
    /// A Boolean value indicating whether this is a secret value.
    ///
    /// Secret values are redacted in logs and debugging output. The default is `false`.
    static var isSecret: Bool { get }
    
    /// The default value to use if the key is not found in any provider.
    static var defaultValue: Value { get }
    
    /// Creates a context for reading this configuration value.
    ///
    /// Override this method to provide custom context based on the SwiftUI environment.
    ///
    /// - Parameter environment: The current SwiftUI environment values.
    /// - Returns: A context dictionary for reading the configuration value.
    static func makeContext(from environment: EnvironmentValues) -> Context
}

public extension ConfigurationKey {
    /// Default implementation returns an empty context.
    static func makeContext(from environment: EnvironmentValues) -> Context { [:] }
    
    /// Default implementation marks values as non-secret.
    static var isSecret: Bool { false }
}

public extension ConfigurationKey where Value: ExpressibleByNilLiteral {
    /// Automatically provides `nil` as the default value for optional types.
    static var defaultValue: Value { nil }
}

