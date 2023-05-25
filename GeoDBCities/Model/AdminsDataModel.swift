//
//  AdminsDataModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/25/23.
//

import Foundation

struct Admins: Codable{
    let data: [Admin]?
}

struct Admin: Codable{
    let id: Int?
    let wikiDataId: String?
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
