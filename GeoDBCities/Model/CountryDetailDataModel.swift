//
//  CountryDetailDataModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/28/23.
//

import Foundation

struct CountryDetailContainer: Codable{
    let data: CountryDetail?
}

struct CountryDetail: Codable{
    let capital: String?
    let code: String?
    let callingCode: String?
    let currencyCodes: [String]?
    let flagImageUri: String?
    let name: String?
    let numRegions: Int?
    let wikiDataId: String?
}
