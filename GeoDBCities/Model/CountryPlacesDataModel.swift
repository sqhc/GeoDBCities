//
//  CountryPlacesDataModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/30/23.
//

import Foundation

struct CountryPlaces: Codable{
    let data: [CountryPlace]?
}

struct CountryPlace: Codable{
    let id: Int?
    let wikiDataId: String?
    let type: String?
    let name: String?
    let region: String?
    let regionCode: String?
    let regionWdId: String?
    let latitude: Double?
    let longitude: Double?
    let population: Int?
}
