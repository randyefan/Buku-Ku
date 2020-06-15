//
//  HandleData.swift
//  Buku-Ku
//
//  Created by Randy Efan Jayaputra on 15/06/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import Foundation

struct Respone: Decodable {
    let result: [Buku]
}

struct Buku: Decodable {
    let id: Int
    let title: String
    let cover: String
    let penulis: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case cover = "cover_url"
        case penulis = "writer_id"
    }
}
