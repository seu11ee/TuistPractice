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
                    Spacer()
                    if let publishedDate = article.publishedDate {
                        Text(publishedDate, style: .date)
                            .font(.caption)
                    } else {
                        Text("-")
                            .font(.caption)
                    }
                }
                
                if let urlString = article.urlToImage, !urlString.isEmpty, let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                imagePlaceholder(showIcon: false)
                                ProgressView()
                                    .progressViewStyle(.circular)
                            }
                            
                        case .success(let image):
                            image
                                .resizable()
                            
                        case .failure(let error):
                            ZStack {
                                imagePlaceholder()
                                Text(error.localizedDescription)
                            }
                            
                        @unknown default:
                            imagePlaceholder()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)
                    .aspectRatio(contentMode: .fill)
                    .clipped()
                } else {
                    imagePlaceholder()
                    
                }
                
                
                
                if let content = article.content {
                    Text(content)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                        
                } else {
                    Text("No content.")
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func imagePlaceholder(showIcon: Bool = true) -> some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .overlay {
                if showIcon {
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                }
            }
            .frame(height: 200)
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
