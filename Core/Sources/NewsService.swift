//
//  NewsService.swift
//  Core
//
//  Created by 이예슬 on 9/10/25.
//

import Foundation

public class NewsService: NewsServiceProtocol {
    private let apiKey: String
    private let baseURL: String
    private let urlSession: URLSession

    public init(
        apiKey: String = "",
        baseURL: String = "",
        urlSession: URLSession = .shared
    ) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    public func fetchTopHeadlines(country: String = "us") async throws -> [Article] {
        print("fetcing API ...")
        print("baseURL:", baseURL)
        print("apiKey:", apiKey)
        guard !baseURL.isEmpty else {
            throw NewsServiceError.invalidURL
        }
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        guard let url = components.url else {
            throw NewsServiceError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NewsServiceError.networkError
        }
        
        switch httpResponse.statusCode {
        case 200:
            break
        case 401:
            throw NewsServiceError.invalidAPIKey
        case 429:
            throw NewsServiceError.rateLimitExceeded
        default:
            throw NewsServiceError.networkError
        }
        
        do {
            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            return newsResponse.articles
        } catch {
            throw NewsServiceError.decodingError
        }
    }
}
