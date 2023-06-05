//
//  CityDetailsDataModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/5/23.
//

import Foundation

struct CityDetailContainer: Codable{
    let data: CityDetail?
}

struct CityDetail: Codable{
    let id: Int?
    let wikiDataId: String?
    let type: String?
    let name: String?
    let country: String?
    let countryCode: String?
    let region: String?
    let elevationMeters: Int?
    let latitude: Double?
    let longitude: Double?
    let population: Int?
    let timezone: String?
}
