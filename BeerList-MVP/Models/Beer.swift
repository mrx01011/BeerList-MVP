//
//  Beer.swift
//  BeerList-MVP
//
//  Created by MacBook on 18.01.2024.
//

import Foundation

struct Beer: Codable, Equatable {
    let id: Int?
    let name: String?
    let description: String?
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case imageURL = "image_url"
    }
}
