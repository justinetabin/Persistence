//
//  MovieRealmStore.swift
//  ExampleTests
//
//  Created by Justine Tabin on 8/12/20.
//  Copyright © 2020 Justine Tabin. All rights reserved.
//

import Foundation
@testable import Example

import RealmSwift
import Quick
import Nimble

class MovieRealmStoreTests: QuickSpec {

    override func spec() {
        describe("MovieRealmStore") {
            var sut: MovieRealmStore!
            
            beforeEach {
                sut = MovieRealmStore(realm: try! Realm())
            }
            
            afterEach {
                sut.realmStore.deleteAll { error in
                    expect(error).to(beNil())
                }
            }
            
            context("inserting a movie") {
                it("should contain in list of movies") {
                    let givenMovie = Movie(
                        trackId: 0,
                        trackName: "Hello World",
                        artistName: "Justine"
                    )
                    
                    var gotMovies: [Movie]?
                    sut.insert(toInsert: givenMovie) { (_) in }
                    sut.list { (movies) in
                        gotMovies = movies
                    }
                    
                    expect(gotMovies).toEventually(contain(givenMovie))
                }
            }
            
            context("updating a movie") {
                it("should contain in lists of movies") {
                    let givenMovie = Movie(
                        trackId: 0,
                        trackName: "Hello World",
                        artistName: "Justine"
                    )
                    let updatedMovie = Movie(
                        trackId: 0,
                        trackName: "Hi World",
                        artistName: "Jasper"
                    )
                    
                    var gotMovies: [Movie]?
                    sut.insert(toInsert: givenMovie) { (_) in }
                    sut.update(toUpdate: updatedMovie) { (_) in }
                    sut.list { (movies) in
                        gotMovies = movies
                    }
                    
                    expect(gotMovies).toEventually(contain(updatedMovie))
                }
            }
        }
    }

}
