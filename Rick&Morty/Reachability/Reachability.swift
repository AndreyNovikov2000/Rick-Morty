//
//  Reachability.swift
//  Rick&Morty
//
//  Created by Andrey Novikov on 12/21/19.
//  Copyright © 2019 Andrey Novikov. All rights reserved.
//

import Foundation

class Reachability {
    
    static let shared = Reachability()
    
    private let statusCode = 200
    
    func isConnectedToNetwork(complition: @escaping (Bool) -> Void) {
        var status = false
        let url = URL(string: GOOGLE_URL)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                
                print("Internet Connection not Available!")
                complition(status)
            }
            else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    
                    status = true
                    print("Internet Connection OK")
                    complition(status)
                    
                }
                print("statusCode: \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
}
