# Changelog

All notable changes to SwiftUIConfiguration will be documented here.

## [0.1.0] - 2025-10-02

### Initial Release 🎉

First public release of SwiftUIConfiguration!

#### Added
- `@Configuration` property wrapper for SwiftUI
- `ConfigurationKey` protocol for type-safe keys
- Support for String, Int, Double, Bool types
- Support for Optional types (String?, Int?, etc.)
- Support for Array types ([String], [Int], etc.)
- Projected value with error, loading state, and last update
- `.configurationReader(_:)` view modifier
- Environment integration
- Secret handling with `isSecret` flag
- 40 comprehensive tests
- Complete documentation (DocC + README)
- GitHub Actions CI/CD

#### Notes
- Built on Apple's [swift-configuration](https://github.com/apple/swift-configuration)
- Requires Swift 6.0+ and latest OS versions
- MIT Licensed

---

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

