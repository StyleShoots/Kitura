// swift-tools-version:5.10

/**
 * Copyright IBM Corporation and the Kitura project authors 2016-2020
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 **/

import PackageDescription
import Foundation

let kituraNetDependency: Package.Dependency = ProcessInfo.processInfo.environment["KITURA_NIO"] != nil
    ? .package(url: "https://github.com/StyleShoots/Kitura-NIO.git", branch: "master")
    : .package(url: "https://github.com/StyleShoots/Kitura-net.git", branch: "master")

let kituraNetProduct: Target.Dependency = ProcessInfo.processInfo.environment["KITURA_NIO"] != nil
    ? .product(name: "KituraNet", package: "Kitura-NIO")
    : .product(name: "KituraNet", package: "Kitura-net")

let package = Package(
    name: "Kitura",
    products: [
        .library(
            name: "Kitura",
            targets: ["Kitura"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Kitura/LoggerAPI.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        kituraNetDependency,
        .package(url: "https://github.com/Kitura/Kitura-TemplateEngine.git", from: "2.0.200"),
        .package(url: "https://github.com/StyleShoots/KituraContracts.git", branch: "master"),
        .package(url: "https://github.com/Kitura/TypeDecoder.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "Kitura",
            dependencies: [
                kituraNetProduct,
                .product(name: "KituraTemplateEngine", package: "Kitura-TemplateEngine"),
                .product(name: "KituraContracts", package: "KituraContracts"),
                .product(name: "TypeDecoder", package: "TypeDecoder"),
                .product(name: "LoggerAPI", package: "LoggerAPI"),
                .product(name: "Logging", package: "swift-log")
            ]
        ),
        .testTarget(
            name: "KituraTests",
            dependencies: [
                "Kitura",
                .product(name: "KituraContracts", package: "KituraContracts"),
                .product(name: "TypeDecoder", package: "TypeDecoder"),
                .product(name: "LoggerAPI", package: "LoggerAPI")
            ]
        )
    ]
)
