import SwiftUI
import Core

@main
struct NewsHubApp: App {
    var body: some Scene {
        WindowGroup {
            NewsListView(newsService: makeNewsService())
        }
    }
    
    private func makeNewsService() -> NewsServiceProtocol {
        return NewsService(apiKey: Bundle.main.newsAPIKey, baseURL: Bundle.main.newsAPIBaseURL)
    }
}
