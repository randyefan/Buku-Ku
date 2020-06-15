//
//  HandleData.swift
//  Buku-Ku
//
//  Created by Randy Efan Jayaputra on 15/06/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import Foundation

struct Respon: Decodable {
    let result: Book
}

struct Book: Decodable {
    let id: Int
    let title: String
    let cover: String
    let desc: String
    let writer: Writer
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case cover = "cover_url"
        case desc = "desc"
        case writer = "Writer_by_writer_id"
    }
}

struct Writer: Decodable {
    let id: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case user = "User_by_user_id"
    }
}

struct User: Decodable {
    let nama: String
    
    enum CodingKeys: String, CodingKey {
        case nama = "name"
    }
}


