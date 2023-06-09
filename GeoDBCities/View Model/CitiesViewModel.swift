//
//  CitiesViewModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/4/23.
//

import Foundation
import Combine

class CitiesViewModel: ObservableObject{
    let location: String
    let countryId: String
    let type: String
    let timezoneId: String
    let prefix: String
    let languageCode: String
    
    var searchCitiesString = "https://wft-geo-db.p.rapidapi.com/v1/geo/cities?"
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
    ]
    
    @Published var cities: Cities?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(location: String = "", id: String = "", type : String = "", timezone: String = "", prefix: String = "", languageCode: String = ""){
        self.location = location
        self.countryId = id
        self.type = type
        self.timezoneId = timezone
        self.prefix = prefix
        self.languageCode = languageCode
    }
    
    func formString(){
        if location != "" && searchCitiesString.last! != "?"{
            searchCitiesString += "&location=\(location)"
        }
        else if location != ""{
            searchCitiesString += "location=\(location)"
        }
        
        if countryId != "" && searchCitiesString.last! != "?"{
            searchCitiesString += "&countryIds=\(countryId)"
        }
        else if countryId != ""{
            searchCitiesString += "countryIds=\(countryId)"
        }
        
        if type != "" && searchCitiesString.last! != "?"{
            searchCitiesString += "&types=\(type)"
        }
        else if type != ""{
            searchCitiesString += "types=\(type)"
        }
        
        if timezoneId != "" && searchCitiesString.last! != "?"{
            searchCitiesString += "&timeZoneIds=\(timezoneId)"
        }
        else if timezoneId != ""{
            searchCitiesString += "timeZoneIds=\(timezoneId)"
        }
        
        if prefix != "" && searchCitiesString.last! != "?"{
            searchCitiesString += "&namePrefix=\(prefix)"
        }
        else if prefix != ""{
            searchCitiesString += "namePrefix=\(prefix)"
        }
        
        if languageCode != "" && searchCitiesString.last! != "?"{
            searchCitiesString += "&languageCode=\(languageCode)"
        }
        else if languageCode != ""{
            searchCitiesString += "languageCode=\(languageCode)"
        }
    }
    
    func fetchCities(){

        formString()
        
        guard let url = URL(string: searchCitiesString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> Cities in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let cities = try? decoder.decode(Cities.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return cities
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] cities in
                self?.cities = cities
            }
            .store(in: &bag)
    }
}

extension CitiesViewModel{
    enum LoadError: LocalizedError{
        case custom(error: Error)
        case failedToDecode
        case invalidStatusCode
        case failedToUnwrapOptional
        
        var errorDescription: String?{
            switch self {
            case .custom(let error):
                return error.localizedDescription
            case .failedToDecode:
                return "Unable to decode data."
            case .invalidStatusCode:
                return "The GET request failed due to invalid status code."
            case .failedToUnwrapOptional:
                return "Failed to unwrap optional value"
            }
        }
    }
}
