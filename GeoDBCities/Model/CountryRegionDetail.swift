//
//  CountryRegionDetail.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/30/23.
//

import Foundation

struct CountryRegionDetailContainer: Codable{
    let data: CountryRegionDetail?
}

struct CountryRegionDetail: Codable{
    let capital: String?
    let countryCode: String?
    let isoCode: String?
    let name: String?
    let numCities: Int?
    let numPlaces: Int?
}
