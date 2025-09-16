//
//  NewsResponse.swift
//  NewsHub
//
//  Created by 이예슬 on 9/9/25.
//

public struct NewsResponse: Codable {
    public let status: String
    public let totalResults: Int
    public let articles: [Article]
}
