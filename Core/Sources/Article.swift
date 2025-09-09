//
//  Article.swift
//  NewsHub
//
//  Created by 이예슬 on 9/9/25.
//

import Foundation

struct Article: Codable, Identifiable {
    var id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let id: String?
    let name: String
}
