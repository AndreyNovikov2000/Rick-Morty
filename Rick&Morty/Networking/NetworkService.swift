//
//  NetworkService.swift
//  Rick&Morty
//
//  Created by Andrey Novikov on 12/14/19.
//  Copyright © 2019 Andrey Novikov. All rights reserved.
//

import Foundation

class NetworkService {
    func request(urlString: String, complition: @escaping ((Data?, URLResponse?, Error?) -> ())) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    complition(nil, nil, error)
                    return
                }
                
                guard let data = data, let response = response else { return }
                complition(data, response, nil)
            }
        }.resume()
    }
}
