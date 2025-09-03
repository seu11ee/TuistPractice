import ProjectDescription

let project = Project(
    name: "NewsHub",
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
                ]
            ),
            buildableFolders: [
                "NewsHub/Sources",
                "NewsHub/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "NewsHubTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "dev.tuist.NewsHubTests",
            infoPlist: .default,
            buildableFolders: [
                "NewsHub/Tests"
            ],
            dependencies: [.target(name: "NewsHub")]
        ),
    ]
)
