//
//  ArticleDetailView.swift
//  NewsHub
//
//  Created by 이예슬 on 10/10/25.
//

import SwiftUI
import Core

struct ArticleDetailView: View {
    let article: Article
    
    init(article: Article) {
        self.article = article
    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 16) {
                Text(article.title)
                    .font(.title)
                    .fontWeight(.bold)
                HStack {
                    Text(article.author ?? "")
                        .font(.caption)
                    if let publishedDate = article.publishedDate {
                        Text(publishedDate, style: .date)
                            .font(.caption)
                    } else {
                        Text("-")
                            .font(.caption)
                    }
                }
                
                // 이미지
                    AsyncImage(url: URL(string: article.urlToImage ?? "")) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                        case .success(let image):
                            image
                                .resizable()

                        case .failure:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray)
                                )
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                
                
                Text(article.content ?? "No content.")
            }
            .padding()
        }
    }
    
}

#Preview {
    NavigationView {
        ArticleDetailView(article: Article(
            source: Source(id: "techcrunch", name: "TechCrunch"),
            author: "Sarah Johnson",
            title: "Apple Announces Revolutionary AI-Powered Features Coming to iOS 19 This Fall",
            description: """
                        Apple unveiled a suite of groundbreaking artificial intelligence features at its annual developer conference today,
                        promising to transform how users interact with their devices.
                        """,
            url: "https://example.com/apple-ios19-ai-features",
            urlToImage: "https://picsum.photos/800/400",
            publishedAt: "2025-10-04T14:30:00Z",
            content: """
                          Apple unveiled a suite of groundbreaking artificial intelligence features at its annual developer conference today, marking
                                one of the most significant updates to iOS in years. The new AI-powered tools will be deeply integrated into iOS 19, set to launch this
                                fall.\n\nAmong the standout features is 'Smart Compose,' an advanced writing assistant that understands context across all apps.
                          """
        ))
    }
    
}
