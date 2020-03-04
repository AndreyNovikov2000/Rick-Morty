//
//  NetworkFetcher.swift
//  Rick&Morty
//
//  Created by Andrey Novikov on 12/14/19.
//  Copyright © 2019 Andrey Novikov. All rights reserved.
//

import Foundation

class NetworkFetcher {
    let networkService = NetworkService()
    var imageData: [Data]!
    
    func fetchChracrter(urlsString: String, complitionHeandler: @escaping ((Chracter?, HTTPURLResponse?) -> Void)) {
        networkService.request(urlString: urlsString) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                complitionHeandler(nil, nil)
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else { return }
            do {
                let chracter = try JSONDecoder().decode(Chracter.self, from: data)
                
                StorageManager.shared.saveChracter(chracter: chracter)
                StorageManager.shared.chracter = chracter
                self.imageData = StorageManager.shared.fetchImageData(with: chracter)
                
                
                complitionHeandler(chracter,httpResponse)
                
                
            } catch let jsonError {
                print(jsonError.localizedDescription)
                complitionHeandler(nil, nil)
            }
        }
    }
}
