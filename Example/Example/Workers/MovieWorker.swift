//
//  MovieWorker.swift
//  Example
//
//  Created by Justine Tabin on 8/12/20.
//  Copyright © 2020 Justine Tabin. All rights reserved.
//

import Foundation

class MovieWorker {
    
}

protocol MovieStore {
    func insert(toInsert movie: Movie, callback: @escaping (Movie?) -> Void)
    func update(toUpdate movie: Movie, callback: @escaping (Movie?) -> Void)
    func delete(trackId: String, callback: @escaping (Movie?) -> Void)
    func list(callback: @escaping ([Movie]) -> Void)
}
