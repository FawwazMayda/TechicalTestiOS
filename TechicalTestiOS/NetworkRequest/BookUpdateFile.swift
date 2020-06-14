//
//  BookUpdateFile.swift
//  TechnicalTest
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation

struct BookUpdateParse: Codable {
    var success: Bool
    var result: [BookUpdate]
}

struct BookUpdate: Codable {
    var id: Int
    var title: String
    var writer_id: Int
    var cover_url: String
    var status: String
    var Writer_by_writer_id: Writer_By_Writer_Id
    var is_update: Bool
    var isNew: Bool
    var view_count: Int
    var rate_sum: Double
    var chapter_count: Int
}
