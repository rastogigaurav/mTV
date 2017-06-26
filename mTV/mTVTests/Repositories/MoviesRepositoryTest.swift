//
//  MovieRepositoryTest.swift
//  mTV
//
//  Created by Gaurav Rastogi on 6/20/17.
//  Copyright © 2017 Gaurav Rastogi. All rights reserved.
//

import XCTest
@testable import mTV

class MoviesRepositoryTest: XCTestCase {
    
    var repository:MoviesRepository?
    var page:Int!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.page = 1
        self.repository = MoviesRepository()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetTopRatedMovies() {
        let moviesExpectation:XCTestExpectation = expectation(description: "Expected to get an array of Top Rated Movies from TMDB")
        repository?.getTopRatedMovies(page:self.page, completionHandler: { (total,movies, error) in
            XCTAssertNotNil(movies)
            XCTAssertNil(error)
            moviesExpectation.fulfill()
        })
        
        // wait for expectations
        waitForExpectations(timeout: 2) { (error) in
            if let _ = error {
                XCTFail("Failed to retreive top rated movies from TMDB")
            }
        }
    }
    
    func testGetUpcomingMovies(){
        let moviesExpectation:XCTestExpectation = expectation(description: "Expected to get an array of Upcoming Movies TMDB")
        repository?.getUpcomingMovies(page:self.page, completionHandler:{ (total,movies, error) in
            XCTAssertNotNil(movies)
            XCTAssertNil(error)
            moviesExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 2) { (error) in
            if let _ = error{
                XCTFail("Failed to retreive upcoming movies from TMDB")
            }
        }
    }
    
    func testGetNowPlayingMovies(){
        let moviesExpectation:XCTestExpectation = expectation(description: "Expected to get an array of Now Playing Movies TMDB")
        repository?.getNowPlayingMovies(page:self.page, completionHandler:{ (total,movies, error) in
            XCTAssertNotNil(movies)
            XCTAssertNil(error)
            moviesExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 2) { (error) in
            if let _ = error{
                XCTFail("Failed to retreive now playing movies from TMDB")
            }
        }
    }
    
    func testGetPopularMovies(){
        let moviesExpectation:XCTestExpectation = expectation(description: "Expected to get an array of Popular Movies TMDB")
        repository?.getPopularMovies(page:self.page, completionHandler:{ (total,movies, error) in
            XCTAssertNotNil(movies)
            XCTAssertNil(error)
            moviesExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 2) { (error) in
            if let _ = error{
                XCTFail("Failed to retreive popular movies from TMDB")
            }
        }
    }
    
    func testSearchMovie(){
        let moviesExpectation:XCTestExpectation = expectation(description: "Expected to get an array of Movies matching the searched keyword from TMDB")
        repository?.searchMovie(withKeyword:"movies", page:self.page, completionHandler:{ (total,movies, error) in
            moviesExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 2) { (error) in
            if let _ = error{
                XCTFail("Failed to retreive popular movies from TMDB")
            }
        }
    }
}
