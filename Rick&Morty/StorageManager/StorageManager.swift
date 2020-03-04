//
//  StorageManager.swift
//  Rick&Morty
//
//  Created by Andrey Novikov on 12/21/19.
//  Copyright © 2019 Andrey Novikov. All rights reserved.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    var chracter: Chracter?
    
    private let userDefault = UserDefaults.standard
    private let networkFetcher = NetworkFetcher()
    
    func saveChracter(chracter: Chracter) {
        guard let chracterData = try? JSONEncoder().encode(chracter) else { return }
        userDefault.set(chracterData, forKey: "chracter")
    }

    
    func fetchChracter() -> Chracter? {
        guard let data = userDefault.object(forKey: "chracter") as? Data else { return chracter }
        guard let chracter = try? JSONDecoder().decode(Chracter.self, from: data) else { return self.chracter }
        
        return chracter
    }
    
    func fetchImageData(with chracter: Chracter) -> [Data] {
        var imageData = [Data]()
        
        for value in chracter.results {
            let urlString = value.image
            guard let url = URL(string: urlString) else { return imageData}
            guard let data = try? Data(contentsOf: url) else { return imageData }
            imageData.append(data)
        }
        return imageData
    }
}
