// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let version = Version("1.46.0")

let gitUrl = "https://maven.sumsub.com/repository/releases/IdensicMobileSDK-iOS/\(version)"

enum checksums {
    static let mrtd = "801d2475c1622539f47d0b3dbf82832ce80c956ac1a58308cedd2933b828c2e1"
}

let package = Package(
    name: "IdensicMobileSDK_MRTDReader",
    platforms: [
        .iOS("13.0")
    ],
    products: [
        .library(
            name: "IdensicMobileSDK_MRTDReader",
            targets: [
                "MRTDReaderWrapper"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SumSubstance/IdensicMobileSDK-iOS.git", .exact(version)),
        .package(url: "https://github.com/krzyzanowskim/OpenSSL", "3.1.5001" ..< "4.0.0"),
        .package(url: "https://github.com/OVD-Kinegram-AG/emrtd-connector-sdk-ios", "2.13.2" ..< "3.0.0")
    ],
    targets: [
        .binaryTarget(
            name: "IdensicMobileSDK_MRTDReader",
            url: "\(gitUrl)/IdensicMobileSDK_MRTDReader-\(version).zip",
            checksum: checksums.mrtd
        ),
        .target(
            name: "MRTDReaderWrapper",
            dependencies: [
                .product(name: "IdensicMobileSDK", package: "IdensicMobileSDK-iOS"),
                "IdensicMobileSDK_MRTDReader",
                "OpenSSL",
                .product(name: "KinegramEmrtdConnector", package: "emrtd-connector-sdk-ios")
            ],
            path: "MRTDReaderWrapper"
        )
    ]
)
