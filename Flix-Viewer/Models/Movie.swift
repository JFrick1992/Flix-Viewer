//
//  Movie.swift
//  Flix-Viewer
//
//  Created by Jacob Frick on 10/6/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit

class Movie {
    var title: String
    var posterUrl: URL?
    var releaseDate: String
    var backdropUrl: URL?
    var overview: String
    static let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        releaseDate = dictionary["release_date"] as? String ?? "No release date"
        let posterPath = dictionary["poster_path"] as? String
        posterUrl = URL(string: (Movie.baseImageURL + posterPath!))
        let backdrop = dictionary["backdrop_path"] as? String
        backdropUrl = URL(string: (Movie.baseImageURL + backdrop!))
    }
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies
    }
    
}
