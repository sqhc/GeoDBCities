//
//  NearAdminsDataModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/26/23.
//

import Foundation

struct NearAdmins: Codable{
    let data: [NearAdmin]?
}

struct NearAdmin: Codable{
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
    let distance: Double?
}
