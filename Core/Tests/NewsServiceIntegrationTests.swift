//
//  NewsServiceIntegrationTests.swift
//  CoreTests
//
//  Created for API integration testing
//

import XCTest
@testable import Core

final class NewsServiceIntegrationTests: XCTestCase {

    func testRealAPICall_WithValidCredentials_ReturnsArticles() async throws {
        // Given: Real NewsService with actual API credentials
        let apiKey = Bundle.main.newsAPIKey
        let baseURL = Bundle.main.newsAPIBaseURL
        let newsService = NewsService(apiKey: apiKey, baseURL: baseURL)

        // When: Fetch top headlines
        let articles = try await newsService.fetchTopHeadlines(country: "us")

        // Then: Should return articles
        XCTAssertFalse(articles.isEmpty, "Should return at least one article from real API")

        // Verify article structure
        let firstArticle = articles[0]
        XCTAssertFalse(firstArticle.title.isEmpty, "Article should have a title")
        XCTAssertFalse(firstArticle.url.isEmpty, "Article should have a URL")
        XCTAssertFalse(firstArticle.source.name.isEmpty, "Article should have a source name")

        print("✅ Successfully fetched \(articles.count) articles from NewsAPI")
        print("First article title: \(firstArticle.title)")
    }

    func testRealAPICall_InvalidAPIKey_ThrowsError() async throws {
        // Given: NewsService with invalid API key
        let newsService = NewsService(
            apiKey: "invalid_key_123",
            baseURL: Bundle.main.newsAPIBaseURL
        )

        // When & Then: Should throw invalidAPIKey error
        do {
            _ = try await newsService.fetchTopHeadlines()
            XCTFail("Should throw error with invalid API key")
        } catch let error as NewsServiceError {
            XCTAssertEqual(error, NewsServiceError.invalidAPIKey, "Should throw invalidAPIKey error")
            print("✅ Correctly detected invalid API key")
        }
    }

    func testURLConstruction_VerifyCorrectFormat() throws {
        // Given: NewsService
        let apiKey = "test_key"
        let baseURL = Bundle.main.newsAPIBaseURL

        // When: Construct URL components
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "country", value: "us"),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]

        guard let url = components.url else {
            XCTFail("Failed to construct URL")
            return
        }

        // Then: Verify URL format
        let urlString = url.absoluteString
        print("Constructed URL: \(urlString)")

        XCTAssertTrue(urlString.contains("top-headlines"), "URL should contain endpoint")
        XCTAssertTrue(urlString.contains("country=us"), "URL should contain country parameter")
        XCTAssertTrue(urlString.contains("apiKey=test_key"), "URL should contain API key")
    }
}
