//
//  WriterDetailFile.swift
//  TechnicalTest
//
//  Created by Muhammad Fawwaz Mayda on 14/06/20.
//  Copyright © 2020 Muhammad Fawwaz Mayda. All rights reserved.
//

import Foundation

struct WriterDetailParse: Codable {
    var success: Bool
    var result: WriterDetail
}

struct WriterDetail: Codable {
    var id: Int
    var name: String
    var username: String
    var photo_url: String
    var phone: String?
    var email: String
    var deskripsi: String
    var karya: [Karya]
}

struct Karya: Codable {
    var id: Int
    var title: String
    var cover_url: String
    var status: String
    var Writer_by_writer_id: Writer_By_Writer_Id
    var bab_count: Int
    var chapter_count: Int
    
    
}
