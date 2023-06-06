//
//  PlacesDataModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/6/23.
//

import Foundation

struct Places: Codable{
    let data: [Place]?
}

struct Place: Codable{
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
