//
//  BookDetailFiles.swift
//  TechnicalTest
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation

struct BookDetailParse: Codable {
    var success: Bool
    var result: BookDetail
}

struct BookDetail: Codable {
    var id: Int
    var title: String
    var synopsis: String
    var cover_url: String
    var Writer_by_writer_id: Writer_By_Writer_Id
}
