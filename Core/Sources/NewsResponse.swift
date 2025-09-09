//
//  NewsResponse.swift
//  NewsHub
//
//  Created by 이예슬 on 9/9/25.
//

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
