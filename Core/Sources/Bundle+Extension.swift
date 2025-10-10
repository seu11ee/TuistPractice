//
//  Bundle+Extension.swift
//  NewsHub
//
//  Created by 이예슬 on 10/5/25.
//

import Foundation

public extension Bundle {
    var newsAPIKey: String {
        object(forInfoDictionaryKey: "NEWS_API_KEY") as? String ?? ""
    }

    var newsAPIBaseURL: String {
        object(forInfoDictionaryKey: "NEWS_API_BASE_URL") as? String ?? ""
    }
}
