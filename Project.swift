import ProjectDescription

let project = Project(
  name: "GetUpTime",
  settings: .settings(configurations: [
    .debug(name: "Debug", xcconfig: "./xcconfigs/GetUpTime-Project.xcconfig"), 
    .release(name: "Release", xcconfig: "./xcconfigs/GetUpTime-Project.xcconfig"), 
  ]),
  targets: [
    .target( 
      name: "GetUpTime", 
      destinations: .iOS, 
      product: .app,
      bundleId: "com.getuptime.app.GetUpTime",
      deploymentTargets: .iOS("16.0"),
      sources: ["GetUpTime/**"],
      resources: [
        "GetUpTime/Resources/Assets.xcassets/**",
        "GetUpTime/Resources/Preview Content/**"
      ], 
      dependencies: [
        .external(name: "Epoxy"),               // Epoxy from epoxy-ios
        .external(name: "Dependencies"),        // Dependencies from swift-dependencies
        .external(name: "DependenciesMacros"),  // DependenciesMacros from swift-dependencies
        .external(name: "SwiftNavigation"),     // SwiftNavigation from swift-navigation
        .external(name: "AppKitNavigation"),    // AppKitNavigation from swift-navigation
        .external(name: "SwiftUINavigation"),   // SwiftUINavigation from swift-navigation
        .external(name: "UIKitNavigation"),     // UIKitNavigation from swift-navigation
      ],
      settings: .settings(configurations: [
        .debug(name: "Debug", xcconfig: "./xcconfigs/GetUpTime.xcconfig"), 
        .release(name: "Release", xcconfig: "./xcconfigs/GetUpTime.xcconfig"), 
      ]) 
    ),
    .target(
        name: "GetUpTimeTests",
        destinations: .iOS,
        product: .unitTests,
        bundleId: "com.getuptime.app.GetUpTime.unitTest",
        sources: ["GetUpTimeTests/**"],
        dependencies: [
            .target(name: "GetUpTime")
        ]
    ),
    .target(
        name: "GetUpTimeUITests",
        destinations: .iOS,
        product: .uiTests,
        bundleId: "com.getuptime.app.GetUpTime.uiTests",
        sources: ["GetUpTimeUITests/**"],
        dependencies: [
            .target(name: "GetUpTime")
        ]
    ),
  ]
)
