//
//  DataManager.swift
//  WhiteAndFluffyTestProject
//
//  Created by Матвей Анкудимов on 02.11.2024.
//

class DataManager {
    
    static let shared = DataManager()
    private var favoritePictures: [Model] = []
    
    func addToFavorite(_ model: Model) {
        if !favoritePictures.contains(where: { $0.id == model.id }) {
            favoritePictures.append(model)
        }
    }
    
    func removeFromFavorite(_ model: Model) {
        favoritePictures.removeAll(where: { $0.id == model.id })
    }
    
    func getFavorite() -> [Model] {
        return favoritePictures
    }
    
    func isFavorite(_ image: Model) -> Bool {
        favoritePictures.contains(where: { $0.id == image.id })
    }
}
