//
//  BookFiles.swift
//  TechnicalTest
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation

struct BookParse: Codable {
    var success: Bool
    var result: [Book]
}

struct Book: Codable {
    var id: Int
    var title: String
    var cover_url: String
    var writer_id: Int
    var created_at: String
    var schedule_task: String
    var status: String
    var Writer_by_writer_id: Writer_By_Writer_Id
    var genre_id: Int
    var Genre_by_genre_id: Genre
    var isNew: Bool
    var view_count: Int
    var rate_sum: Double
    var is_update: Bool
    var chapter_count: Int
}

struct Writer_By_Writer_Id: Codable {
    var id: Int
    var user_id: Int
    var created_at: String?
    var kelas: String?
    var status: String?
    var schedule_task: String?
    var royalty_id: Int?
    var type: String?
    var User_by_user_id: User_By_User_Id
    
}

struct User_By_User_Id: Codable {
    var id: Int
    var name: String
}

