# Defining Configuration Keys

Create type-safe configuration keys for your application.

## Overview

Configuration keys provide a type-safe way to define and access configuration values in your SwiftUI application. Each key specifies a name, default value, and optional metadata.

### Basic Configuration Key

Create a configuration key by conforming to the ``ConfigurationKey`` protocol:

```swift
struct APIEndpointKey: ConfigurationKey {
    static let name = "API_ENDPOINT"
    static let defaultValue = "https://api.example.com"
}
```

### Adding Convenience Extensions

Make your keys easier to use by adding static properties:

```swift
extension ConfigurationKey where Self == APIEndpointKey {
    /// The API endpoint configuration key.
    static var apiEndpoint: Self { .init() }
}

// Usage - clean and concise
@Configuration(.apiEndpoint) var endpoint
```

### Supported Types

SwiftUIConfiguration supports the following types:

#### Primitive Types
- `String`
- `Int`
- `Double`
- `Bool`

```swift
struct PortKey: ConfigurationKey {
    static let name = "PORT"
    static let defaultValue = 8080
}

struct EnableDebugKey: ConfigurationKey {
    static let name = "ENABLE_DEBUG"
    static let defaultValue = false
}
```

#### Optional Types
- `String?`
- `Int?`
- `Double?`
- `Bool?`

```swift
struct OptionalAPIKeyKey: ConfigurationKey {
    static let name = "API_KEY"
    static let defaultValue: String? = nil
}

// Automatically provides nil default
extension ConfigurationKey where Value: ExpressibleByNilLiteral {
    static var defaultValue: Value { nil }
}
```

#### Array Types
- `[String]`
- `[Int]`
- `[Double]`
- `[Bool]`

```swift
struct AllowedIPsKey: ConfigurationKey {
    static let name = "ALLOWED_IPS"
    static let defaultValue: [String] = []
}
```

### Secret Values

Mark sensitive configuration values as secrets:

```swift
struct PrivateKeyKey: ConfigurationKey {
    static let name = "PRIVATE_KEY"
    static let defaultValue = ""
    static let isSecret = true
}
```

Secret values are:
- Redacted in logs
- Handled specially by debugging tools
- Excluded from access reports by default

### Custom Context

Provide custom context based on the SwiftUI environment:

```swift
struct UserSpecificKey: ConfigurationKey {
    static let name = "USER_PREFERENCE"
    static let defaultValue = "default"
    
    static func makeContext(from environment: EnvironmentValues) -> Context {
        // You can access environment values to customize the context
        var context: Context = [:]
        
        // Example: add locale information
        if let locale = environment.locale {
            context["locale"] = locale.identifier
        }
        
        return context
    }
}
```

### Complete Example

Here's a complete example with multiple configuration keys:

```swift
import SwiftUIConfiguration

// API Configuration
struct APIEndpointKey: ConfigurationKey {
    static let name = "API_ENDPOINT"
    static let defaultValue = "https://api.example.com"
}

struct APITimeoutKey: ConfigurationKey {
    static let name = "API_TIMEOUT"
    static let defaultValue: TimeInterval = 30
}

struct APIKeyKey: ConfigurationKey {
    static let name = "API_KEY"
    static let defaultValue = ""
    static let isSecret = true  // Mark as secret
}

// Feature Flags
struct FeatureNewUIKey: ConfigurationKey {
    static let name = "FEATURE_NEW_UI"
    static let defaultValue = false
}

// Extensions for convenience
extension ConfigurationKey where Self == APIEndpointKey {
    static var apiEndpoint: Self { .init() }
}

extension ConfigurationKey where Self == APITimeoutKey {
    static var apiTimeout: Self { .init() }
}

extension ConfigurationKey where Self == APIKeyKey {
    static var apiKey: Self { .init() }
}

extension ConfigurationKey where Self == FeatureNewUIKey {
    static var featureNewUI: Self { .init() }
}

// Usage in views
struct SettingsView: View {
    @Configuration(.apiEndpoint) var endpoint
    @Configuration(.apiTimeout) var timeout
    @Configuration(.apiKey) var apiKey
    @Configuration(.featureNewUI) var useNewUI
    
    var body: some View {
        Form {
            Section("API Settings") {
                LabeledContent("Endpoint", value: endpoint)
                LabeledContent("Timeout", value: "\(Int(timeout))s")
                LabeledContent("Key", value: apiKey.isEmpty ? "Not set" : "***")
            }
            
            Section("Features") {
                Toggle("New UI", isOn: .constant(useNewUI))
            }
        }
    }
}
```

## Topics

### Protocol
- ``ConfigurationKey``

### Using Configuration Keys
- ``Configuration``

