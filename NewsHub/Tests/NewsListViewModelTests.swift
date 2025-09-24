//
//  NewsListViewModelTests.swift
//  NewsHubTests
//
//  Created by 이예슬 on 9/18/25.
//

import XCTest
@testable import NewsHub
@testable import Core
@testable import TestHelpers

@MainActor
final class NewsListViewModelTests: XCTestCase {
    var viewModel: NewsListViewModel!
    var mockNewsService: MockNewsService!
    var sampleSource: Source!
    var sampleArticle: Article!
    
    override func setUp() {
        super.setUp()
        mockNewsService = MockNewsService()
        viewModel = NewsListViewModel(newsService: mockNewsService)
        sampleSource = Source(id: "test-id", name: "Test News")
        sampleArticle = Article(
            source: sampleSource,
            author: "Test Author",
            title: "Test Article Title",
            description: "Test article description",
            url: "https://test.com/article",
            urlToImage: "https://test.com/image.jpg",
            publishedAt: "2025-09-18T10:00:00Z",
            content: "Test article content"
        )
    }

    override func tearDown() {
        viewModel = nil
        mockNewsService = nil
        super.tearDown()
    }
    
    // 1단계: 가장 간단한 테스트 - 초기 상태 확인
    func testInitialState() {
        XCTAssertEqual(viewModel.articles.count, 0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    // 2단계: 성공 케이스 테스트
    func testLoadNews_Success() async {
        // Given - 테스트용 샘플 데이터 준비
        mockNewsService.mockArticles = [sampleArticle]
        
        await viewModel.loadNews()
        
        XCTAssertEqual(viewModel.articles.count, 1)
        XCTAssertEqual(viewModel.articles.first?.title, "Test Article Title")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testLoadNews_Failure() async {
        mockNewsService.shouldThrowError = true
        
        await viewModel.loadNews()
        
        XCTAssertEqual(viewModel.articles.count, 0)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.errorMessage?.isEmpty ?? true) // 에러메세지가 비어있지 않은지 체크
    }
    
    func testLoadNews_LoadingState() async {
        mockNewsService.mockArticles = [sampleArticle]
        
        let loadTask = Task {
            await viewModel.loadNews()
        }
        try? await Task.sleep(nanoseconds: 100_000_000)
        XCTAssertTrue(viewModel.isLoading)
        
        await loadTask.value
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertEqual(viewModel.articles.count, 1)
    }
    
}

