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
    
    func fetchChracrter(urlsString: String, complitionHeandler: @escaping ((Chracter?) -> ())) {
        networkService.request(urlString: urlsString) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                complitionHeandler(nil)
            }

            guard let data = data else { return }
            
            do {
             
                let chracter = try JSONDecoder().decode(Chracter.self, from: data)
                complitionHeandler(chracter)
                
            } catch let jsonError {
                print(jsonError.localizedDescription)
                complitionHeandler(nil)
            }
        }
    }
}
