//
//  MockNewsService.swift
//  NewsHub
//
//  Created by 이예슬 on 9/10/25.
//

@testable import Core

class MockNewsService: NewsServiceProtocol {
    var mockArticles: [Article] = []
    var shouldThrowError: Bool = false
    func fetchTopHeadlines(country: String = "us") async throws -> [Article] {
        if shouldThrowError {
            throw NewsServiceError.networkError
        }
        return mockArticles
    }
}
