//
//  RealmMovie.swift
//  Example
//
//  Created by Justine Tabin on 8/12/20.
//  Copyright © 2020 Justine Tabin. All rights reserved.
//

import RealmSwift

class RealmMovie: Object {
    @objc dynamic var trackId: Int = 0
    @objc dynamic var trackName: String = ""
    @objc dynamic var artistName: String = ""
    
    override class func primaryKey() -> String? {
        "trackId"
    }
    
    static func from(movie: Movie) -> RealmMovie {
        .init(value: [
            "trackId": movie.trackId,
            "trackName": movie.trackName,
            "artistName": movie.artistName
        ])
    }
    
    func toMovie() -> Movie {
        Movie(
            trackId: trackId,
            trackName: trackName,
            artistName: artistName
        )
    }
}
