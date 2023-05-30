//
//  CountryRegionsDataModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/30/23.
//

import Foundation

struct CountryRegions: Codable{
    let data: [CountryRegion]?
}

struct CountryRegion: Codable{
    let countryCode: String?
    let fipsCode: String?
    let isoCode: String?
    let name: String?
    let wikiDataId: String?
}
