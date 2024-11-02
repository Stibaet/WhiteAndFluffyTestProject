//
//  DataManager.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 02.11.2024.
//

class DataManager {
    
    static let shared = DataManager()
    private var favoritesPictures: [Model] = []
    
    func addToFavorites(_ model: Model) {
        if !favoritesPictures.contains(where: { $0.id == model.id }) {
            favoritesPictures.append(model)
        }
    }
    
    func removeFromFavorites(_ model: Model) {
        favoritesPictures.removeAll(where: { $0.id == model.id })
    }
    
    func getFavorites() -> [Model] {
        return favoritesPictures
    }
    
    func isFavorite(_ image: Model) -> Bool {
        favoritesPictures.contains(where: { $0.id == image.id })
    }
}
