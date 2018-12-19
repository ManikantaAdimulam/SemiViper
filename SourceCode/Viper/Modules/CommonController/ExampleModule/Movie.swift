//
//  Movie.swift
//  Viper
//
//  Created by Manikanta on 12/12/18.
//  Copyright © 2018 Siddhant Jain. All rights reserved.
//

import Foundation
import SwiftyJSON
class Movies {
    ///
    var movies: [Movie]
    
    init(json: JSON) {
        self.movies = json["movies"].arrayValue.map {Movie(json: $0)}
    }
}

struct Movie {
    ///
    var name: String
    ///
    var rating: String
    ///
    var description: String
    ///
    var thumbnailUrl: String
    init(json: JSON) {
        self.name = json["title_english"].stringValue
        self.rating = json["rating"].stringValue
        self.description = json["summary"].stringValue
        self.thumbnailUrl = json["medium_cover_image"].stringValue
    }
}
