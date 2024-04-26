//
//  MarvelComicRepositoryTests.swift
//  HanbaiTests
//
//  Created by Pajaziti Labinot on 26.4.24..
//

import XCTest
@testable import Hanbai

class ComicInteractorTests: XCTestCase {
    
    // Mock ComicRepository for testing
    class MockComicRepository: ComicRepository {
        var comics: [Comic]?
        var error: AppError?
        
        func fetchComics(completion: @escaping (Result<[Comic], AppError>) -> Void) {
            if let comics = comics {
                completion(.success(comics))
            } else if let error = error {
                completion(.failure(error))
            } else {
                // Provide a default error for testing
                completion(.failure(.networkError("Unknown error")))
            }
        }
    }
    
    func testFetchComicsSuccess() {
        // Arrange
        let repository = MockComicRepository()
        let interactor = ComicInteractor(comicRepository: repository)
        let expectedComics = [Comic(id: 1, title: "Comic 1", creators: ComicCreators(items: []))]
        repository.comics = expectedComics
        
        // Act & Assert
        interactor.fetchComics { result in
            XCTAssertEqual(try? result.get(), expectedComics, "Returned comics should match expected comics")
        }
    }

    
    func testFetchComicsFailure() {
        // Arrange
        let repository = MockComicRepository()
        let interactor = ComicInteractor(comicRepository: repository)
        let expectedError = AppError.networkError("Test error")
        
        // Set up mock error
        repository.error = expectedError
        
        // Act
        interactor.fetchComics { result in
            // Assert
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error, expectedError, "Returned error should match expected error")
            }
        }
    }
}
