// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SkillzSDK",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "SkillzBridge",
            targets: ["SkillzBridge"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SkillzBridge",
            dependencies: [
                "Skillz",
                "KochavaCore",
                "KochavaTracker",
                "SkillzOpenTelemetryApi",
                "GCSDKDomain",
                "GeoComplySDK",
                "GeoComplySDK2110"
            ],
            publicHeadersPath: "include"
        ),
        .binaryTarget(
            name: "Skillz",
            path: "BinaryTargets/Skillz.xcframework"
        ),
        .binaryTarget(
            name: "KochavaCore",
            path: "BinaryTargets/KochavaCore.xcframework"
        ),
        .binaryTarget(
            name: "KochavaTracker",
            path: "BinaryTargets/KochavaTracker.xcframework"
        ),
        .binaryTarget(
            name: "SkillzOpenTelemetryApi",
            path: "BinaryTargets/OpenTelemetryApi.xcframework"
        ),
        .binaryTarget(
            name: "GCSDKDomain",
            path: "GeocomplySDKs/GCSDKDomain.xcframework"
        ),
        .binaryTarget(
            name: "GeoComplySDK",
            path: "GeocomplySDKs/GeoComplySDK.xcframework"
        ),
        .binaryTarget(
            name: "GeoComplySDK2110",
            path: "GeocomplySDKs/GeoComplySDK2110.xcframework"
        )
    ],
    swiftLanguageVersions: [
        .v5
    ],
    cxxLanguageStandard: .cxx14
)
