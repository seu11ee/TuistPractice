//
//  NewsServiceProtocol.swift
//  NewsHub
//
//  Created by 이예슬 on 9/10/25.
//

public protocol NewsServiceProtocol {
    public func fetchTopHeadlines(country: String) async throws -> [Article]
}
