//
//  Model.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import Foundation

struct Constants {
    static let apiKey = "RR7ZJ8iyN_3d8xKS5xZzoTrVzMY0IplVFZU1U1ykmWg"
}

struct Model: Codable {
    let id: String
    let urls: [String: String]
    let user: User
    let createdAt: String?
    let location: Location?
    let downloads: Int?
    
    
    struct User: Codable {
        let name: String
    }
    
    struct Location: Codable {
        let name: String?
    }
}
