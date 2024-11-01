//
//  NetworkErrors.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import Foundation

enum NetworkErrors: Error {
    case invalidURL
    case decodingError
    case noInternetConnection
    case serverError(code: Int)
    case unknownError
}
