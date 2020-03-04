//
//  Result.swift
//  Rick&Morty
//
//  Created by Andrey Novikov on 12/14/19.
//  Copyright © 2019 Andrey Novikov. All rights reserved.
//

struct Result: Decodable, Encodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: Origin
    let location: Location
    let image: String
}

struct Origin: Decodable, Encodable {
    let name: String
}

struct Location: Decodable, Encodable {
    let name: String
}
