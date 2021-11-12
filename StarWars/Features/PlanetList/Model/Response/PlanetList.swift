//
//  PlanetList.swift
//  StarWars
//
//  Created by Oshitha on 11/12/21.
//

import Foundation

// MARK: - PlanetListResponse
struct PlanetList: Codable {
    let results: [PlanetListItem]
}

// MARK: - Result
struct PlanetListItem: Codable {
    let name, rotationPeriod, orbitalPeriod, diameter: String
    let climate, gravity, terrain, surfaceWater: String
    let population: String
    let residents, films: [String]
    let created, edited: String
    let url: String
    let id:Int?

    enum CodingKeys: String, CodingKey {
        case name
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter, climate, gravity, terrain
        case surfaceWater = "surface_water"
        case population, residents, films, created, edited, url, id
    }
}
