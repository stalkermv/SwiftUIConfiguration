// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

struct PortConfigurationKey: ConfigurationKey {
    static let isSecret: Bool = false
    static var defaultValue: Int { 8080 }
    static let name: String = "PORT"
}

extension ConfigurationKey where Self == PortConfigurationKey {
    static var port: PortConfigurationKey { .init() }
}


struct Test1ConfigurationKey: ConfigurationKey {
    static let defaultValue: Double = 1.0
    static let name: String = "TEST1"
}

extension ConfigurationKey where Self == Test1ConfigurationKey {
    static var test1: Test1ConfigurationKey { .init() }
}


struct Test2ConfigurationKey: ConfigurationKey {
    static let defaultValue: String = "Test2"
    static let name: String = "TEST2"
}

extension ConfigurationKey where Self == Test2ConfigurationKey {
    static var test2: Test2ConfigurationKey { .init() }
}


struct Test3ConfigurationKey: ConfigurationKey {
    static let defaultValue: [Bool] = [true, false, true]
    static let name: String = "TEST3"
}

extension ConfigurationKey where Self == Test3ConfigurationKey {
    static var test3: Test3ConfigurationKey { .init() }
}

struct Test4OptionalConfigurationKey: ConfigurationKey {
    static let defaultValue: String? = nil
    static let name: String = "TEST4"
}

extension ConfigurationKey where Self == Test4OptionalConfigurationKey {
    static var test4: Test4OptionalConfigurationKey { .init() }
}

struct ExampleView: View {
    @Configuration(.port) private var port
    @Configuration(.test1) private var test1
    @Configuration(.test2) private var test2
    @Configuration(.test3) private var test3
    @Configuration(.test4) private var test4

    var body: some View {
        VStack(spacing: 8) {
            Text("Port: \(port)")
            Text("Test1: \(test1)")
            Text("Test2: \(test2)")
            Text("Test3: \(test3)")
            Text("Test4: \(test4 ?? "nil")")
            
            // Using projected value for error handling
            if let error = $port.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
            }
            
            // Using projected value for loading state
            if $port.isLoading {
                ProgressView("Loading configuration...")
            }
            
            // Using projected value for last update info
            if let lastUpdate = $port.lastUpdate {
                Text("Last updated: \(lastUpdate.formatted())")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

import Configuration

#Preview {
    let config = ConfigReader(providers: [
        // First check environment variables.
        EnvironmentVariablesProvider(),
        // Finally, use hardcoded defaults.
        InMemoryProvider(values: [
            "PORT": 9090,
            "TEST1": 3.14,
            "TEST2": "Hello, World!",
            "TEST4": "Hello, World!"
        ])
    ])
    
    ExampleView()
        .configurationReader(config)
}
