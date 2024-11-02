//
//  NetworkManager.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 01.11.2024.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    func getPictures(completion: @escaping (Result<[Model], NetworkErrors>) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/photos/random?count=20&client_id=\(Constants.apiKey)") else {
            completion(.failure(.invalidURL))
            print("invalid URL")
            return
        }
        
        guard NetworkReachabilityManager()?.isReachable == true else {
            completion(.failure(.noInternetConnection))
            print("lost connection")
            return
        }
        
        AF.request(url).validate(statusCode: 200..<300).responseDecodable(of: [Model].self) { response in
            switch response.result {
                case .success(let pictures):
                    completion(.success(pictures))
                    
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        completion(.failure(.serverError(code: statusCode)))
                        print("\(error.localizedDescription)")
                    } else if error.isResponseSerializationError {
                        completion(.failure(.decodingError))
                        print("\(error.localizedDescription)")
                    } else {
                        completion(.failure(.unknownError))
                        print("unknown error")
                    }
            }
        }
    }
}
