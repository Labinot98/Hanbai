//
//  ComicsViewModelTests.swift
//  HanbaiTests
//
//  Created by Pajaziti Labinot on 26.4.24..
//

import XCTest
@testable import Hanbai

// Mock ComicUseCase for testing
class MockComicUseCase: ComicUseCase {
    func fetchComics(completion: @escaping (Result<[Hanbai.Comic], Hanbai.AppError>) -> Void) {
        completion(.success(comics))
    }
    
    var comics: [Comic] = []
}

class ComicsViewModelTests: XCTestCase {
    
    func testGroupComicsByCreators() {
        // Arrange
        let viewModel = ComicsViewModel(comicUseCase: MockComicUseCase())
        let comics = [
            Comic(id: 1, title: "Comic 1", creators: ComicCreators(items: [Creator(name: "Creator A", role: "Writer")])),
            Comic(id: 2, title: "Comic 2", creators: ComicCreators(items: [Creator(name: "Creator A", role: "Artist")])),
            Comic(id: 3, title: "Comic 3", creators: ComicCreators(items: [Creator(name: "Creator B", role: "Writer")])),
            Comic(id: 4, title: "Comic 4", creators: ComicCreators(items: [Creator(name: "Creator B", role: "Artist")]))
        ]
        
        // Act
        let groupedComics = viewModel.groupComicsByCreators(comics)
        
        // Assert
        XCTAssertEqual(groupedComics.count, 2)
        XCTAssertEqual(groupedComics["Creator A"]?.count, 2)
        XCTAssertEqual(groupedComics["Creator B"]?.count, 2)
    }
    
    
    func testFetchComics() {
        // Arrange
        let viewModel = ComicsViewModel(comicUseCase: MockComicUseCase())
        
        // Set up mock comics
        let comics = [
            Comic(id: 1, title: "Comic 1", creators: ComicCreators(items: [Creator(name: "Creator A", role: "Writer")])),
            Comic(id: 2, title: "Comic 2", creators: ComicCreators(items: [Creator(name: "Creator B", role: "Artist")]))
        ]
        
        // Set up the mock comic use case to return the mock comics
        let mockUseCase = viewModel.comicUseCase as! MockComicUseCase
        mockUseCase.comics = comics
        
        // Act
        viewModel.fetchComics()
        
        // Assert
        XCTAssertTrue(viewModel.isLoading) // Expect loading to start
        XCTAssertEqual(viewModel.groupedComics.count, 0)
        
        // Simulate the asynchronous fetching of comics by waiting for a short duration
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Assert after the fetch is completed
            XCTAssertFalse(viewModel.isLoading)
            XCTAssertEqual(viewModel.groupedComics.count, 2)
        }
    }
}
