//
//  NewsListViewModel.swift
//  NewsHub
//
//  Created by 이예슬 on 9/17/25.
//

import Core
import SwiftUI

@MainActor
class NewsListViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    var filteredArticles: [Article] {
          if searchText.isEmpty {
              return articles
          } else {
              return articles.filter { article in
                  article.title.localizedCaseInsensitiveContains(searchText) ||
                  article.description?.localizedCaseInsensitiveContains(searchText) == true
              }
          }
      }
    @Published var searchText: String = ""
    
    private let newsService: NewsServiceProtocol
    
    init(newsService: NewsServiceProtocol) {
        self.newsService = newsService
    }
    
    func loadNews() async {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        do {
            articles = try await newsService.fetchTopHeadlines(country: "us")
        }
        catch {
            if let newsError = error as? NewsServiceError {
                errorMessage = formatErrorMessage(for: newsError)
            } else {
                errorMessage = "An unexpected error occurred"
            }
        }
        
        isLoading = false
    }
    
    private func formatErrorMessage(for error: NewsServiceError) -> String {
              switch error {
              case .networkError:
                  return "Network connection failed. Please check your internet."
              case .invalidAPIKey:
                  return "Service temporarily unavailable."
              case .rateLimitExceeded:
                  return "Too many requests. Please try again later."
              case .decodingError:
                  return "Failed to load news data."
              case .invalidURL:
                  return "Invalid URL."
              }
          }
}
