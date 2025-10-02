# SwiftUIConfiguration

[![Tests](https://github.com/stalkermv/SwiftUIConfiguration/actions/workflows/tests.yml/badge.svg)](https://github.com/stalkermv/SwiftUIConfiguration/actions/workflows/tests.yml)
[![Swift 6.0+](https://img.shields.io/badge/Swift-6.0+-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-lightgrey.svg)](https://developer.apple.com)

SwiftUI integration for Apple's [Swift Configuration](https://github.com/apple/swift-configuration) library.

- 📚 **Documentation** - Available inline and via DocC
- 💻 **Examples** - See [examples below](#examples)
- 🚀 **Contributions** - Welcome! See [CONTRIBUTING.md](CONTRIBUTING.md)
- 🪪 **License** - MIT License, see [LICENSE](LICENSE)

## Overview

SwiftUIConfiguration provides a declarative `@Configuration` property wrapper that brings type-safe configuration management to SwiftUI applications. It seamlessly integrates with SwiftUI's environment system and supports all configuration providers from the Swift Configuration library.

## Features

- ✅ **SwiftUI Property Wrapper** - Use `@Configuration` in your views
- ✅ **Type-Safe** - Leverage Swift's type system for configuration keys
- ✅ **All Standard Types** - String, Int, Double, Bool, and their arrays
- ✅ **Optional Support** - Full support for optional values
- ✅ **Projected Value** - Access errors, loading state, and metadata via `$`
- ✅ **Provider Hierarchy** - Environment variables, JSON, YAML, and more
- ✅ **Secrets Support** - Built-in handling for sensitive values
- ✅ **Hot Reloading** - Dynamic updates with reactive SwiftUI integration

## Installation

> Important: While SwiftUIConfiguration's API is in development, use `.upToNextMinor(from: "...")` to avoid unexpected breaking changes.

Add to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/apple/swift-configuration.git", from: "0.1.0"),
    .package(url: "https://github.com/stalkermv/SwiftUIConfiguration.git", .upToNextMinor(from: "0.1.0"))
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "Configuration", package: "swift-configuration"),
            .product(name: "SwiftUIConfiguration", package: "SwiftUIConfiguration")
        ]
    )
]
```

## Quick Start

### 1. Define Configuration Keys

```swift
import SwiftUIConfiguration

struct APIEndpointKey: ConfigurationKey {
    static let name = "API_ENDPOINT"
    static let defaultValue = "https://api.example.com"
}

struct APITimeoutKey: ConfigurationKey {
    static let name = "API_TIMEOUT"
    static let defaultValue: TimeInterval = 30
}

// Convenience extensions for cleaner API
extension ConfigurationKey where Self == APIEndpointKey {
    static var apiEndpoint: Self { .init() }
}

extension ConfigurationKey where Self == APITimeoutKey {
    static var apiTimeout: Self { .init() }
}
```

### 2. Set Up Configuration in Your App

```swift
import SwiftUI
import Configuration
import SwiftUIConfiguration

@main
struct MyApp: App {
    let config: ConfigReader
    
    init() {
        // Create configuration reader with provider hierarchy
        config = ConfigReader(providers: [
            // 1. Check environment variables first
            EnvironmentVariablesProvider(),
            
            // 2. Fall back to hardcoded defaults
            InMemoryProvider(values: [
                "API_ENDPOINT": "https://api.production.com",
                "API_TIMEOUT": 30
            ])
        ])
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .configurationReader(config)
        }
    }
}
```

### 3. Use Configuration in Views

```swift
struct ContentView: View {
    @Configuration(.apiEndpoint) var endpoint
    @Configuration(.apiTimeout) var timeout
    
    var body: some View {
        VStack {
            Text("API Endpoint: \(endpoint)")
            Text("Timeout: \(Int(timeout))s")
        }
    }
}
```

## Advanced Usage

### Error Handling with Projected Value

Access configuration metadata using the `$` prefix:

```swift
struct StatusView: View {
    @Configuration(.apiKey) var apiKey
    
    var body: some View {
        VStack {
            Text("API Key: \(apiKey)")
            
            // Access error
            if let error = $apiKey.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            }
            
            // Show loading state
            if $apiKey.isLoading {
                ProgressView("Loading...")
            }
            
            // Display last update
            if let lastUpdate = $apiKey.lastUpdate {
                Text("Updated: \(lastUpdate.formatted())")
                    .font(.caption)
            }
        }
    }
}
```

### Optional Values

```swift
struct OptionalKeyKey: ConfigurationKey {
    static let name = "OPTIONAL_KEY"
    static let defaultValue: String? = nil
}

struct MyView: View {
    @Configuration(.optionalKey) var value
    
    var body: some View {
        if let value {
            Text("Value: \(value)")
        } else {
            Text("Not configured")
        }
    }
}
```

### Array Values

```swift
struct AllowedHostsKey: ConfigurationKey {
    static let name = "ALLOWED_HOSTS"
    static let defaultValue: [String] = []
}

struct SecurityView: View {
    @Configuration(.allowedHosts) var hosts
    
    var body: some View {
        List(hosts, id: \.self) { host in
            Text(host)
        }
    }
}
```

### Secret Values

```swift
struct PrivateKeyKey: ConfigurationKey {
    static let name = "PRIVATE_KEY"
    static let defaultValue = ""
    static let isSecret = true  // Redacted in logs
}

@Configuration(.privateKey) var privateKey
```

## Supported Types

- **Primitive**: `String`, `Int`, `Double`, `Bool`
- **Optional**: `String?`, `Int?`, `Double?`, `Bool?`
- **Arrays**: `[String]`, `[Int]`, `[Double]`, `[Bool]`
- **Optional Arrays**: `[String]?`, `[Int]?`, `[Double]?`, `[Bool]?`

## Configuration Providers

SwiftUIConfiguration supports all providers from [swift-configuration](https://github.com/apple/swift-configuration#configuration-providers). Choose the provider that fits your needs:

### Available Providers

- **[EnvironmentVariablesProvider](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration/environmentvariablesprovider)** - Read from environment variables
- **[CommandLineArgumentsProvider](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration/commandlineargumentsprovider)** - Parse command-line arguments  
- **[JSONProvider](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration/jsonprovider)** / **[ReloadingJSONProvider](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration/reloadingjsonprovider)** - JSON files (with hot-reloading)
- **[YAMLProvider](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration/yamlprovider)** / **[ReloadingYAMLProvider](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration/reloadingyamlprovider)** - YAML files (with hot-reloading)
- **[DirectoryFilesProvider](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration/directoryfilesprovider)** - Directory of files (perfect for Docker/Kubernetes secrets)
- **[InMemoryProvider](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration/inmemoryprovider)** / **[MutableInMemoryProvider](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration/mutableinmemoryprovider)** - In-memory values
- **[KeyMappingProvider](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration/keymappingprovider)** - Transform keys

> For complete provider documentation, see [Configuration Providers](https://github.com/apple/swift-configuration#configuration-providers) and the [Swift Package Index docs](https://swiftpackageindex.com/apple/swift-configuration/documentation/configuration#Built-in-providers).

### Provider Examples

#### Environment Variables

```swift
let config = ConfigReader(provider: EnvironmentVariablesProvider())
```

Set via shell:
```bash
export API_ENDPOINT="https://api.staging.com"
```

#### JSON File

```swift
let config = ConfigReader(
    provider: try await JSONProvider(filePath: "/etc/myapp/config.json")
)
```

#### YAML with Hot-Reloading

```swift
let config = ConfigReader(
    provider: try await ReloadingYAMLProvider(filePath: "/etc/myapp/config.yaml")
)
// Automatically reloads when file changes!
```

#### Directory Files (Kubernetes/Docker Secrets)

```swift
let config = ConfigReader(
    provider: try await DirectoryFilesProvider(directoryPath: "/run/secrets")
)
// Reads individual files: /run/secrets/api-key, /run/secrets/db-password
```

#### Provider Hierarchy

Combine providers with fallback priority:

```swift
let config = ConfigReader(providers: [
    EnvironmentVariablesProvider(),           // 1. Highest priority
    try await JSONProvider(filePath: "config.json"),  // 2. Fallback to JSON
    InMemoryProvider(values: ["PORT": 8080])  // 3. Defaults
])
```

The first provider with a value wins. Perfect for environment-specific overrides!

## Documentation

Full documentation is available in the DocC catalog. 

### View in Xcode
Open `Package.swift` in Xcode, then go to **Product → Build Documentation** or press `⌃⌘D`.

### Build from Command Line
```bash
swift package generate-documentation --target SwiftUIConfiguration
```

## Testing

Run the comprehensive test suite:

```bash
swift test
```

## Requirements

- Swift 6.0+
- macOS 15.0+ / iOS 18.0+ / tvOS 18.0+ / watchOS 11.0+
- [Swift Configuration](https://github.com/apple/swift-configuration) 0.1.0+

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on how to submit pull requests, report issues, and contribute to the project.

## License

SwiftUIConfiguration is available under the MIT license. See [LICENSE](LICENSE) for details.

This project uses [swift-configuration](https://github.com/apple/swift-configuration) which is licensed under the Apache License 2.0. See [NOTICE](NOTICE) for third-party licenses.

## Author

Created and maintained by [Valeriy Malishevskyi](https://github.com/stalkermv).

## Acknowledgments

Built on top of Apple's [swift-configuration](https://github.com/apple/swift-configuration) library.

Special thanks to the Swift community and Apple for creating the excellent Swift Configuration library.

