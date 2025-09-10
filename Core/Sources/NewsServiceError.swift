//
//  NewsServiceError.swift
//  Core
//
//  Created by 이예슬 on 9/10/25.
//

import Foundation

public enum NewsServiceError: Error, LocalizedError {
    case networkError
    case decodingError
    case invalidURL
    case invalidAPIKey
    case rateLimitExceeded

    public var errorDescription: String? {
        switch self {
        case .networkError:
            return "Network connection failed"
        case .decodingError:
            return "Failed to decode response"
        case .invalidURL:
            return "Invalid URL"
        case .invalidAPIKey:
            return "Invalid API key"
        case .rateLimitExceeded:
            return "API rate limit exceeded"
        }
    }
}
