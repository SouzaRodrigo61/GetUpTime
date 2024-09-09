// swift-tools-version: 5.10
import PackageDescription

#if TUIST
  import ProjectDescription

  let packageSettings = PackageSettings(
    productTypes: [:]
  )
#endif

let package = Package(
  name: "GetUpTime",
  dependencies: [
    // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
    .package(url: "https://github.com/pointfreeco/swift-perception", from: "1.3.5"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.3.9"),
    .package(url: "https://github.com/pointfreeco/swift-navigation", from: "2.2.0"),
    .package(url: "https://github.com/airbnb/epoxy-ios", branch: "master"),
  ]
)
