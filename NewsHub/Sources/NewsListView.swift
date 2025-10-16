//
//  NewsListView.swift
//  NewsHub
//
//  Created by 이예슬 on 9/24/25.
//

import SwiftUI
import Core

struct NewsListView: View {
    @StateObject private var viewModel: NewsListViewModel

    init(newsService: NewsServiceProtocol) {
        self._viewModel = StateObject(wrappedValue: NewsListViewModel(newsService: newsService))
    }
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading && viewModel.filteredArticles.isEmpty {
                    ProgressView("Loading...")
                }
                else if let error = viewModel.errorMessage {
                    makeErrorView(errorMessage: error)
                } else {
                    List(viewModel.filteredArticles) {
                        article in
                        NavigationLink(value: article) {
                            
                            makeArticleRowView(article)
                        }
                    }
                    .searchable(text: $viewModel.searchText, prompt: "Search news")
                    .refreshable {
                        await viewModel.loadNews()
                    }
                }
            }
            .navigationTitle("NewsHub")
            .navigationDestination(for: Article.self) {
                article in ArticleDetailView(article: article)
            }
        }
        .onAppear {
            Task { await viewModel.loadNews() }
        }
    }
    
    private func makeArticleRowView(_ article: Article) -> some View {
        return VStack(alignment: .leading, spacing: 8) {
            Text(article.title)
                .font(.headline)

            if let description = article.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            HStack {
                Text(article.source.name)
                    .font(.caption)
                    .foregroundColor(.blue)
                Spacer()
                if let publishedDate = article.publishedDate {
                    Text(publishedDate, style: .date)
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    Text("—")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }
        }
        .padding(.vertical, 4)
    }
    private func makeErrorView(errorMessage: String) -> some View {
        VStack(spacing: 16) {
            Text("⚠️").font(.system(size: 50))
            Text(errorMessage).foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            Button("Retry") {
                Task { await viewModel.loadNews() }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#if DEBUG
public class ListViewMockNewsService: NewsServiceProtocol {
    var mockArticles: [Article] {
        (0..<100).map { index in
            Article(
                source: Source(id: "source-\(index)", name: "Source \(index)"),
                author: "Author \(index)",
                title: "Title \(index)",
                description: "Description \(index)",
                url: "https://example.com/\(index)",
                urlToImage: "https://example.com/image\(index).jpg",
                publishedAt: "2024-01-\(String(format: "%02d", (index % 28) + 1))T00:00:00Z",
                content: "Content \(index)"
            )
        }
    }
    var shouldThrowError: Bool = false
    public func fetchTopHeadlines(country: String = "us") async throws -> [Article] {
        
        if shouldThrowError {
            throw NewsServiceError.networkError
        }
        try await Task.sleep(nanoseconds: 1_300_000_000)
        
        return mockArticles
    }
}
#endif

#Preview {
    return NewsListView(newsService: ListViewMockNewsService())
}
