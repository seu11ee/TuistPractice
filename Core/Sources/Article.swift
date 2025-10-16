//
//  Article.swift
//  NewsHub
//
//  Created by 이예슬 on 9/9/25.
//

import Foundation

public struct Article: Codable, Identifiable, Hashable {
    public static func == (lhs: Article, rhs: Article) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var id: UUID = UUID()
    public let source: Source
    public let author: String?
    public let title: String
    public let description: String?
    public let url: String
    public let urlToImage: String?
    public let publishedAt: String
    public let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt, content
    }
    
    public init(source: Source, author: String?, title: String, description: String?, url: String, urlToImage: String?, publishedAt: String, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}

public struct Source: Codable, Hashable {
    public let id: String?
    public let name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
}

extension Article {
    public var publishedDate: Date? {
        ISO8601DateFormatter().date(from: publishedAt)
    }
}
