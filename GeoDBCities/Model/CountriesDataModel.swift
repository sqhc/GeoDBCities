//
//  CountriesDataModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/28/23.
//

import Foundation

struct Countries: Codable{
    let data: [Country]?
}

struct Country: Codable{
    let code: String?
    let currencyCodes: [String]?
    let name: String?
    let wikiDataId: String?
}
