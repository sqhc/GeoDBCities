//
//  CityNearbyDataModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/6/23.
//

import Foundation

struct CityNearbys: Codable{
    let data: [CityNearby]?
}

struct CityNearby: Codable{
    let id: Int?
    let wikiDataId: String?
    let type: String?
    let name: String?
    let country: String?
    let region: String?
    let latitude: Double?
    let longitude: Double?
    let population: Int?
    let distance: Double?
}
