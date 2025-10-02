# Getting Started

Integrate SwiftUIConfiguration into your SwiftUI app.

## Overview

SwiftUIConfiguration makes it easy to use configuration values in SwiftUI applications by providing a `@Configuration` property wrapper that works seamlessly with SwiftUI's environment system.

### Installation

Add SwiftUIConfiguration and its dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/apple/swift-configuration.git", from: "0.1.0"),
    .package(url: "https://github.com/yourusername/SwiftUIConfiguration.git", from: "0.1.0")
],
targets: [
    .target(
        name: "MyApp",
        dependencies: [
            .product(name: "Configuration", package: "swift-configuration"),
            .product(name: "SwiftUIConfiguration", package: "SwiftUIConfiguration")
        ]
    )
]
```

### Setting Up Configuration in Your App

Configure your `ConfigReader` at the app's entry point:

```swift
import SwiftUI
import Configuration
import SwiftUIConfiguration

@main
struct MyApp: App {
    let config: ConfigReader
    
    init() {
        // Create a hierarchy of configuration providers
        config = ConfigReader(providers: [
            // 1. Environment variables (highest priority)
            EnvironmentVariablesProvider(),
            
            // 2. Hardcoded defaults (lowest priority)
            InMemoryProvider(values: [
                "API_ENDPOINT": "https://api.production.com",
                "API_TIMEOUT": 30,
                "FEATURE_FLAG_NEW_UI": true
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

### Using Configuration in Views

Use the `@Configuration` property wrapper to access configuration values:

```swift
struct ContentView: View {
    @Configuration(.apiEndpoint) var apiEndpoint
    @Configuration(.apiTimeout) var timeout
    @Configuration(.featureFlagNewUI) var useNewUI
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Endpoint: \(apiEndpoint)")
            Text("Timeout: \(timeout)s")
            
            if useNewUI {
                NewUIView()
            } else {
                LegacyUIView()
            }
        }
    }
}
```

### Handling Errors and Loading States

Use the projected value (`$`) to access configuration metadata:

```swift
struct ConfigStatusView: View {
    @Configuration(.apiKey) var apiKey
    
    var body: some View {
        VStack {
            // Show the value
            Text("API Key: \(apiKey)")
            
            // Handle errors
            if let error = $apiKey.error {
                Label {
                    Text(error.localizedDescription)
                } icon: {
                    Image(systemName: "exclamationmark.triangle")
                }
                .foregroundColor(.red)
            }
            
            // Show loading indicator
            if $apiKey.isLoading {
                ProgressView()
            }
            
            // Display last update timestamp
            if let lastUpdate = $apiKey.lastUpdate {
                Text("Last updated: \(lastUpdate.formatted())")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}
```

### Provider Hierarchy

Configuration providers are checked in order. The first provider with a value wins:

```swift
let config = ConfigReader(providers: [
    // 1. Environment variables - highest priority
    EnvironmentVariablesProvider(),
    
    // 2. JSON config file
    try await JSONProvider(filePath: "/etc/myapp/config.json"),
    
    // 3. In-memory defaults - lowest priority
    InMemoryProvider(values: [
        "API_ENDPOINT": "https://api.default.com"
    ])
])
```

If `API_ENDPOINT` is set as an environment variable, it will be used. Otherwise, the JSON file is checked, and finally the in-memory defaults.

## Topics

### Setting Up Your App
- <doc:Defining-Configuration-Keys>

### Reading Configuration
- ``Configuration``
- ``Configuration/Projection``

### Environment Integration  
- ``SwiftUI/View/configurationReader(_:)``

