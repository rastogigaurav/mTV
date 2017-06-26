//
//  DisplayMoviesTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/22/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class DisplayMoviesTest: XCTestCase {
    
    var moviesRepository:MoviesRepositoryMock = MoviesRepositoryMock()
    var displayMovies:DisplayMovies?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.displayMovies = DisplayMovies(with: moviesRepository)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    func testFetchForTopRatedMoviesSection(){
        let moviesExpectation:XCTestExpectation = expectation(description: "Expected fetch top rated movies and should called various relevant method of movies repository")
        self.displayMovies?.displayMovies(forSection: MovieSections.topRated, withPage: 1, completionHandler: { (total,movies, section) in
            XCTAssertTrue((self.moviesRepository.getTopRatedMoviesIsCalled))
            moviesExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 4.0) { (error) in
            if let _ = error{
                XCTFail("Failed to call fetch Movies from Repository")
            }
        }
    }
    
    func testFetchForUpcomingMoviesSection(){
        let moviesExpectation:XCTestExpectation = expectation(description: "Expected fetch upcoming movies and should called various relevant method of movies repository")
        self.displayMovies?.displayMovies(forSection: MovieSections.upcoming, withPage: 1, completionHandler: { (total,movies, section) in
            XCTAssertTrue((self.moviesRepository.getUpcomingMoviesIsCalled))
            moviesExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 4.0) { (error) in
            if let _ = error{
                XCTFail("Failed to call fetch Movies from Repository")
            }
        }
    }
    
    func testFetchForNowPlayingMoviesSection(){
        let moviesExpectation:XCTestExpectation = expectation(description: "Expected fetch now playing movies and should called various relevant method of movies repository")
        self.displayMovies?.displayMovies(forSection: MovieSections.nowPlaying, withPage: 1, completionHandler: { (total,movies, section) in
            XCTAssertTrue((self.moviesRepository.getNowPlayingMoviesIsCalled))
            moviesExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 4.0) { (error) in
            if let _ = error{
                XCTFail("Failed to call fetch Movies from Repository")
            }
        }
    }
    
    func testFetchForPopularMoviesSection(){
        let moviesExpectation:XCTestExpectation = expectation(description: "Expected fetch popular movies and should called various relevant method of movies repository")
        self.displayMovies?.displayMovies(forSection: MovieSections.popular, withPage: 1, completionHandler: { (total,movies, section) in
            XCTAssertTrue((self.moviesRepository.getPopularMoviesIsCalled))
            moviesExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 4.0) { (error) in
            if let _ = error{
                XCTFail("Failed to call fetch Movies from Repository")
            }
        }
    }
    
    func testFilterMoviesByReleaseDate(){
        let expectedResult:XCTestExpectation = expectation(description: "Expected to filter the movie list based on release dates")

        displayMovies?.filter(movieList: [Movie(json: Dictionary())], startYear: 1000, endYear: 1000, completionHandler: { (filteredMovies) in
            XCTAssertEqual(filteredMovies.count, 0)
            expectedResult.fulfill()
        })
        
        waitForExpectations(timeout: 2.0) { (error) in
            if let _ = error{
                XCTFail("Failed to filter the movie list based on release dates")
            }
        }
    }
}
