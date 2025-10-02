# Security Policy

## Reporting Security Issues

Found a security issue? Please let me know!

**Don't post it publicly** - instead:
- Email me or use [GitHub Security Advisories](https://github.com/stalkermv/SwiftUIConfiguration/security/advisories/new)
- I'll respond as soon as I can (usually within a few days)

## Security Tips

### Handling Secrets

Mark sensitive values as secrets:

```swift
struct APIKeyKey: ConfigurationKey {
    static let name = "API_KEY"
    static let defaultValue = ""
    static let isSecret = true  // Redacted in logs
}
```

### Best Practices
- Don't commit secrets to git
- Use environment variables or secure stores for production
- Mark sensitive config as `isSecret = true`

## Dependencies

This library depends on [swift-configuration](https://github.com/apple/swift-configuration). Check their [security policy](https://github.com/apple/swift-configuration/security/policy) too.

