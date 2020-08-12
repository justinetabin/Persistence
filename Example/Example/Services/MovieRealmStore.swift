//
//  MovieRealmStore.swift
//  Example
//
//  Created by Justine Tabin on 8/12/20.
//  Copyright © 2020 Justine Tabin. All rights reserved.
//

import RealmSwift
import Persistence

class MovieRealmStore: MovieStore {
    var realmStore: RealmStore<RealmMovie>

    init(realm: Realm) {
        self.realmStore = RealmStore(realm: realm)
    }

    func insert(toInsert movie: Movie, callback: @escaping (Movie?) -> Void) {
        realmStore.insert(toInsert: .from(movie: movie)) { (rlmMovie, error) in
            callback(rlmMovie?.toMovie())
        }
    }

    func update(toUpdate movie: Movie, callback: @escaping (Movie?) -> Void) {
        realmStore.update(toUpdate: .from(movie: movie)) { (rlmMovie, error) in
            callback(rlmMovie?.toMovie())
        }
    }

    func delete(trackId: String, callback: @escaping (Movie?) -> Void) {
        realmStore.get(primaryKey: trackId) { (movie, _) in
            callback(movie?.toMovie())
        }
    }

    func list(callback: @escaping ([Movie]) -> Void) {
        realmStore.list { (results, error) in
            if let results = results {
                var movies = [Movie]()
                results.forEach { (rlmMovie) in
                    movies.append(rlmMovie.toMovie())
                }
                callback(movies)
            } else {
                callback([])
            }
        }
    }
}
