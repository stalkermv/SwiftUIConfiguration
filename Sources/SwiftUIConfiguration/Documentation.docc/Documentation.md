# ``SwiftUIConfiguration``

SwiftUI integration for Apple's Swift Configuration library.

## Overview

SwiftUIConfiguration brings the power of [swift-configuration](https://github.com/apple/swift-configuration) to SwiftUI applications. It provides a declarative `@Configuration` property wrapper that seamlessly integrates with SwiftUI's environment system.

### Quick Start

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/apple/swift-configuration.git", from: "0.1.0"),
    .package(url: "https://github.com/yourusername/SwiftUIConfiguration.git", from: "0.1.0")
]
```

### Basic Usage

Define your configuration keys:

```swift
import SwiftUIConfiguration

struct APIEndpointKey: ConfigurationKey {
    static let name = "API_ENDPOINT"
    static let defaultValue = "https://api.example.com"
}

extension ConfigurationKey where Self == APIEndpointKey {
    static var apiEndpoint: Self { .init() }
}
```

Set up your configuration in your app:

```swift
import SwiftUI
import Configuration
import SwiftUIConfiguration

@main
struct MyApp: App {
    let config: ConfigReader
    
    init() {
        // Configure your providers hierarchy
        config = ConfigReader(providers: [
            // First check environment variables
            EnvironmentVariablesProvider(),
            // Then use hardcoded defaults
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

Use configuration in your views:

```swift
struct ContentView: View {
    @Configuration(.apiEndpoint) var endpoint
    
    var body: some View {
        Text("API: \(endpoint)")
    }
}
```

### Advanced Features

#### Error Handling with Projected Value

Access configuration metadata using the projected value:

```swift
struct StatusView: View {
    @Configuration(.apiKey) var apiKey
    
    var body: some View {
        VStack {
            Text("API Key: \(apiKey)")
            
            // Access error information
            if let error = $apiKey.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            }
            
            // Show loading state
            if $apiKey.isLoading {
                ProgressView("Loading configuration...")
            }
            
            // Display last update time
            if let lastUpdate = $apiKey.lastUpdate {
                Text("Updated: \(lastUpdate.formatted())")
                    .font(.caption)
            }
        }
    }
}
```

#### Optional Values

Support for optional configuration values:

```swift
struct OptionalAPIKeyKey: ConfigurationKey {
    static let name = "OPTIONAL_API_KEY"
    static let defaultValue: String? = nil
}

struct MyView: View {
    @Configuration(.optionalAPIKey) var apiKey
    
    var body: some View {
        if let apiKey {
            Text("API Key: \(apiKey)")
        } else {
            Text("No API key configured")
        }
    }
}
```

#### Array Values

Configuration supports arrays of primitive types:

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

## Topics

### Essentials
- <doc:Getting-Started>
- <doc:Defining-Configuration-Keys>

### Property Wrapper
- ``Configuration``
- ``Configuration/Projection``

### Configuration Keys
- ``ConfigurationKey``

### Environment Integration
- ``SwiftUI/View/configurationReader(_:)``
- ``SwiftUI/EnvironmentValues/configReader``