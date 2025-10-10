import ProjectDescription

let project = Project(
    name: "NewsHub",
    settings: .settings(
        configurations: [
            .debug(name: .debug, xcconfig: .relativeToRoot("Config/Config.xcconfig")),
            .release(name: .release, xcconfig: .relativeToRoot("Config/Config.xcconfig"))
        ]
    ),
    targets: [
    	.target(
	        name: "Core",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.NewsHub.Core",
            sources: ["Core/Sources/**"]
         ),
        .target(
            name: "TestHelpers",
            destinations: .iOS,
            product: .framework,
            bundleId: "dev.tuist.NewsHub.TestHelpers",
            sources: ["TestHelpers/Sources/**"],
            dependencies: [.target(name: "Core")]
        ),
        .target(
            name: "NewsHub",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.NewsHub.App",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
		    "NEWS_API_KEY": "$(NEWS_API_KEY)",
		    "NEWS_API_BASE_URL": "$(NEWS_API_BASE_URL)",
		    "NSAppTransportSecurity": [
		        "NSAllowsArbitraryLoads": true
		    ]
                ]
            ),
            sources: ["NewsHub/Sources/**"],
            resources: ["NewsHub/Resources/**"],
            dependencies: [.target(name: "Core")]
        ),
        .target(
            name: "CoreTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.NewsHub.CoreTests",
            sources: ["Core/Tests/**"],
            dependencies: [
                .target(name: "Core"),
                .target(name: "TestHelpers")
            ]
        ),            
        .target(
            name: "NewsHubTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.NewsHubTests",
            infoPlist: .default,
            sources: ["NewsHub/Tests/**"],
            dependencies: [
                .target(name: "NewsHub"),
                .target(name: "TestHelpers")
            ]
        ),
    ]
)
