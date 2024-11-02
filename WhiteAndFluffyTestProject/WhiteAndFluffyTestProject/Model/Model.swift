//
//  Model.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import Foundation
import UIKit

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
    
    enum CodingKeys: String, CodingKey {
        case id
        case urls
        case user
        case createdAt = "created_at"
        case location
        case downloads
    }
    
    struct User: Codable {
        let name: String
    }
    
    struct Location: Codable {
        let name: String?
    }
    
}

struct SearchResults: Codable {
    let total: Int
    let results: [Results]

    enum CodingKeys: String, CodingKey {
        case total
        case results
    }
    
    struct Results: Codable {
        let id: String
        let width: Int
        let height: Int
        let user: Model.User
        let createdAt: String?
        let urls: [String: String]

        enum CodingKeys: String, CodingKey {
            case id
            case width
            case height
            case user
            case createdAt = "created_at"
            case urls
        }
    }
}


