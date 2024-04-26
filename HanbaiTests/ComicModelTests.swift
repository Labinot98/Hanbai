//
//  HanbaiTests.swift
//  HanbaiTests
//
//  Created by Pajaziti Labinot on 24.4.24..
//

import XCTest
@testable import Hanbai

class ComicModelTests: XCTestCase {
    
    func testComicModel() {
        // Given
        let id = 1
        let title = "Test Comic"
        let creator = Creator(name: "Test Creator", role: "Test Role")
        let creators = ComicCreators(items: [creator])
        let comic = Comic(id: id, title: title, creators: creators)
        
        // Then
        XCTAssertEqual(comic.id, id)
        XCTAssertEqual(comic.title, title)
        XCTAssertEqual(comic.creators.items.count, 1)
        XCTAssertEqual(comic.creators.items.first?.name, "Test Creator")
        XCTAssertEqual(comic.creators.items.first?.role, "Test Role")
    }
    
    func testResponseModel() {
        // Given
        let creator = Creator(name: "Test Creator", role: "Test Role")
        let creators = ComicCreators(items: [creator])
        let comic = Comic(id: 1, title: "Test Comic", creators: creators)
        let comicData = ComicData(results: [comic])
        let response = Response(data: comicData)
        
        // Then
        XCTAssertEqual(response.data.results.count, 1)
        XCTAssertEqual(response.data.results.first?.id, 1)
        XCTAssertEqual(response.data.results.first?.title, "Test Comic")
        XCTAssertEqual(response.data.results.first?.creators.items.count, 1)
        XCTAssertEqual(response.data.results.first?.creators.items.first?.name, "Test Creator")
        XCTAssertEqual(response.data.results.first?.creators.items.first?.role, "Test Role")
    }
}
