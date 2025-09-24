//
//  MockNewsService.swift
//  NewsHub
//
//  Created by 이예슬 on 9/10/25.
//

@testable import Core

public class MockNewsService: NewsServiceProtocol {
    var mockArticles: [Article] = []
    var shouldThrowError: Bool = false
    public func fetchTopHeadlines(country: String = "us") async throws -> [Article] {
        if shouldThrowError {
            throw NewsServiceError.networkError
        }
        try await Task.sleep(nanoseconds: 150_000_000)
        return mockArticles
    }
}
