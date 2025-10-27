// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        productTypes: [:]
    )
#endif

let package = Package(
    name: "NewsHub",
    dependencies: [
        // Add your own dependencies here:
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
    ]
)
