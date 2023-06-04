//
//  CitiesDataModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/4/23.
//

import Foundation

struct Cities: Codable{
    let data: [City]?
}

struct City: Codable{
    let id: Int?
    let wikiDataId: String?
    let type: String?
    let name: String?
    let country: String?
    let countryCode: String?
    let region: String?
    let regionCode: String?
    let regionWdId: String?
    let latitude: Double?
    let longitude: Double?
    let population: Int?
}
