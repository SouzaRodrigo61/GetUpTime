import ProjectDescription

let project = Project(
  name: "GetUpTime",
  settings: .settings(configurations: [
    .debug(name: "Debug", xcconfig: "./xcconfigs/GetUpTime-Project.xcconfig"), 
    .debug(name: "Release", xcconfig: "./xcconfigs/GetUpTime-Project.xcconfig"), 
  ]),
  targets: [
    .target( 
      name: "GetUpTime", 
      destinations: .iOS, 
      product: .app,
      bundleId: "com.getuptime.app.GetUpTime", 
      sources: ["GetUpTime/**"], 
      dependencies: [], 
      settings: .settings(configurations: [ 
        .debug(name: "Debug", xcconfig: "./xcconfigs/GetUpTime.xcconfig"), 
        .debug(name: "Release", xcconfig: "./xcconfigs/GetUpTime.xcconfig"), 
      ]) 
    ), 
  ]
)
