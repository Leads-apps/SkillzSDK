// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SkillzSDK",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "SkillzBridge",
            targets: ["SkillzBridge"]
        ),
        .executable(
            name: "SkillzSampleApp",
            targets: ["SkillzSampleApp"]
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
        .executableTarget(
            name: "SkillzSampleApp",
            dependencies: [
                "Skillz"
            ],
            path: "Examples/SkillzSampleApp/SkillzSampleApp",
            swiftSettings: [
                .define("SKILLZ_SAMPLE_APP", .when(platforms: [.iOS]))
            ]
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
