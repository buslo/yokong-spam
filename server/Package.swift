// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "server",
  products: [
    .library(name: "server", targets: ["server"]),
    .executable(name: "serverApp", targets: ["serverApp"]),
  ],
  dependencies: [
    .package(name: "YokongCommon", path: "../common"),
    .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
    .package(url: "https://github.com/vapor/fluent-postgres-driver.git", from: "2.0.0"),
  ],
  targets: [
    .target(name: "server",
            dependencies: [.product(name: "Vapor", package: "vapor"),
                           .product(name: "Fluent", package: "fluent"),
                           .product(name: "FluentPostgresDriver", package: "fluent-postgres-driver")]),
    .executableTarget(name: "serverApp", dependencies: ["server"]),
    .testTarget(name: "serverTests", dependencies: ["server"]),
  ]
)
