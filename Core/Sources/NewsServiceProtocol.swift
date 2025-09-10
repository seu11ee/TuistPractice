//
//  NewsServiceProtocol.swift
//  NewsHub
//
//  Created by 이예슬 on 9/10/25.
//

protocol NewsServiceProtocol {
    func fetchTopHeadlines() async throws -> [Article]
}
