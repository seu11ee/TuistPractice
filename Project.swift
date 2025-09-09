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
            name: "NewsHub",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.NewsHub",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
		    "NEWS_API_KEY": "$(NEWS_API_KEY)",
		    "NEWS_API_BASE_URL": "$(NEWS_API_BASE_URL)"
                ]
            ),
            sources: ["NewsHub/Sources/**"],
            resources: ["NewsHub/Resources/**"],
            dependencies: []
        ),
        .target(
            name: "NewsHubTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.NewsHubTests",
            infoPlist: .default,
            sources: ["NewsHub/Tests/**"],
            dependencies: [.target(name: "NewsHub")]
        ),
    ]
)
