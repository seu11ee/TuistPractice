//
//  NewsListViewModelTests.swift
//  NewsHubTests
//
//  Created by 이예슬 on 9/18/25.
//

import XCTest
@testable import NewsHub
@testable import TestHelpers

@MainActor
final class NewsListViewModelTests: XCTestCase {
    var viewModel: NewsListViewModel!
    var mockNewsService: MockNewsService!

    override func setUp() {
        super.setUp()
        mockNewsService = MockNewsService()
        viewModel = NewsListViewModel(newsService: mockNewsService)
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
}

