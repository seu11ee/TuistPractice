//
//  NewsServiceTests.swift
//  CoreTests
//
//  Created by 이예슬 on 9/9/25.
//

import XCTest
@testable import Core

final class NewsServiceTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    func testFetchTopHeadLines_WhenEmptyArray_ReturnsSuccess() async throws {
        // Given: Mock service that returns articles
        let mockService = MockNewsService()
        // When: Fetch top headlines
        mockService.mockArticles = []
        let articles = try await mockService.fetchTopHeadlines()
        // Then: Should return expected articles
        XCTAssertTrue(articles.isEmpty, "Articles can be empty when no news available")
    }
    
    func testFetchTopHeadlines_WhenValidResponse_ReturnsSuccess() async throws {
        let mockArticlesCount = 3
        let mockService = MockNewsService()
        mockService.mockArticles = createMockArticles(count: mockArticlesCount)
        
        let articles = try await mockService.fetchTopHeadlines()
        
        XCTAssertEqual(articles.count, mockArticlesCount, "Should return \(mockArticlesCount) articles")
        XCTAssertFalse(articles[0].title.isEmpty, "Article title should not be empty")
        XCTAssertFalse(articles[0].url.isEmpty, "Article URL should not be empty")
    }

    func testFetchTopHeadlines_NetworkError_ThrowsError() async {
        // Given: Mock service that throws network error
        let mockService = MockNewsService()
        mockService.shouldThrowError = true

        // When & Then: Should throw error
        do {
            _ = try await mockService.fetchTopHeadlines()
            XCTFail("Should throw network error")
        } catch {
            XCTAssertTrue(error is NewsServiceError, "Should throw NewsServiceError")
        }
    }
    
    private func createMockArticles(count: Int) -> [Article] {
        return (0..<count).map { index in
            Article(
                source: Source(id: "source-\(index)", name: "Source \(index)"),
                author: "Author \(index)",
                title: "Title \(index)",
                description: "Description \(index)",
                url: "https://example.com/\(index)",
                urlToImage: "https://example.com/image\(index).jpg",
                publishedAt: "2024-01-0\(index + 1)T00:00:00Z",
                content: "Content \(index)"
            )
        }
    }
}
