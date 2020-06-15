//
//  HandleGenre.swift
//  Buku-Ku
//
//  Created by Randy Efan Jayaputra on 15/06/20.
//  Copyright © 2020 Randy Efan Jayaputra. All rights reserved.
//

import Foundation

struct Response: Decodable {
    let resource: [Genre]
}

struct Genre: Decodable {
    let id: Int
    let title: String
    
    enum CodingKeys: String, CodingKey  {
        case id = "id"
        case title = "title"
    }
}
