# SkillzSDK Swift Package

Swift Package Manager wrapper for the proprietary Skillz SDK and its native dependencies.  
This package exposes the existing Objective-C++ bridge (`SkillzBridge`) plus the bundled binary SDKs (Skillz, Kochava, OpenTelemetry, GeoComply) so that iOS apps can integrate Skillz entirely through SPM.

## Contents

| Target | Type | Notes |
| --- | --- | --- |
| `SkillzBridge` | Clang target | Ships the original `Skillz.mm` Objective-C++ bridge and public headers (`Skillz.hpp`, `SkillzBridgingHeader.h`). |
| `Skillz` | Binary target | XCFramework converted from the provided `Skillz.framework`. |
| `KochavaCore`, `KochavaTracker` | Binary targets | Kochava analytics SDKs (arm64). |
| `SkillzOpenTelemetryApi` | Binary target | Renamed wrapper for the bundled OpenTelemetry framework to avoid clashes with upstream packages. |
| `GCSDKDomain`, `GeoComplySDK`, `GeoComplySDK2110` | Binary targets | GeoComply XCFrameworks included as-is. |

## Requirements

- Xcode 15 / Swift 5.9 (minimum tools-version used by the manifest)
- iOS 12.0 or later deployment target
- Access to the private GitHub repository `https://github.com/Leads-apps/SkillzSDK.git`

## Installation

### Xcode

1. `File > Add Packages…`
2. Enter the repository URL `https://github.com/Leads-apps/SkillzSDK.git`
3. Select the desired version (e.g. `v1.0.1`) and add the `SkillzBridge` product to your app target.

### Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/Leads-apps/SkillzSDK.git", exact: "1.0.1")
],
targets: [
    .target(
        name: "MyGame",
        dependencies: [
            .product(name: "SkillzBridge", package: "SkillzSDK")
        ])
]
```

## Using the Bridge

1. Import the C++ API header where you interact with the SDK:
   ```cpp
   #include <SkillzBridge/Skillz.hpp>
   ```
2. If you need Swift/Objective-C access, add `SkillzBridgingHeader.h` to your target’s bridging header:
   ```objc
   #import <SkillzBridge/SkillzBridgingHeader.h>
   ```
3. Initialize Skillz early in your app lifecycle by passing your delegate implementation:
   ```objective-c++
   skillz::Skillz::Init(&myDelegate);
   skillz::Skillz::Launch();
   ```

The `SkillzBridge` target automatically links the Skillz, Kochava, OpenTelemetry, and GeoComply binaries when added to your app target; no manual framework embedding is required.

## Versioning

- `v1.0.0` – Initial SwiftPM release.
- `v1.0.1` – Renamed OpenTelemetry target (`SkillzOpenTelemetryApi`) to avoid conflicts with other packages.

Use semantic version tags to consume future updates.

## Development Notes

- All binary frameworks were converted to XCFrameworks for compatibility with current Apple Silicon/Xcode toolchains.
- If you obtain updated binaries from Skillz or partners, replace the corresponding `BinaryTargets/*.xcframework` bundle and bump the package version.
