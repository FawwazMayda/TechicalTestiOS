//
//  GenreFiles.swift
//  TechnicalTest
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation


struct GenreParse: Codable {
    var resource : [Genre]
}

struct Genre: Codable {
    var id : Int
    var title : String
    var icon_url : String?
    var count : Int
}
