//
//  NetworkService.swift
//  Rick&Morty
//
//  Created by Andrey Novikov on 12/14/19.
//  Copyright © 2019 Andrey Novikov. All rights reserved.
//

import Foundation

class NetworkService {
    func request(urlString: String, complition: @escaping ((Data?, Error?) -> ())) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    complition(nil, error)
                    return
                }
                guard let data = data else { return }
                complition(data, nil)
            }
        }.resume()
    }
}
