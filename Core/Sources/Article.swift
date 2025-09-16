//
//  Article.swift
//  NewsHub
//
//  Created by 이예슬 on 9/9/25.
//

import Foundation

public struct Article: Codable, Identifiable {
    public var id = UUID()
    public let source: Source
    public let author: String?
    public let title: String
    public let description: String?
    public let url: String
    public let urlToImage: String?
    public let publishedAt: String
    public let content: String?
}

public struct Source: Codable {
    public let id: String?
    public let name: String
}
