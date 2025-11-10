// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "EndlessWallet",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "EndlessWallet",
            targets: ["EndlessWallet"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stripe/stripe-ios", from: "23.0.0"),
        .package(url: "https://github.com/plaid/plaid-link-ios", from: "5.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire", from: "5.8.0"),
    ],
    targets: [
        .target(
            name: "EndlessWallet",
            dependencies: [
                .product(name: "StripePaymentSheet", package: "stripe-ios"),
                .product(name: "LinkKit", package: "plaid-link-ios"),
                "Alamofire"
            ]),
    ]
)
