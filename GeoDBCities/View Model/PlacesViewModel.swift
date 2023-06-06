//
//  PlacesViewModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/6/23.
//

import Foundation
import Combine

class PlacesViewModel: ObservableObject{
    let location: String
    let countryId: String
    let type: String
    let timezoneId: String
    let prefix: String
    let languageCode: String
    
    var searchPlacesString = "https://wft-geo-db.p.rapidapi.com/v1/geo/places?"
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
    ]
    
    @Published var places: Places?
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
        if location != "" && searchPlacesString.last! != "?"{
            searchPlacesString += "&location=\(location)"
        }
        else if location != ""{
            searchPlacesString += "location=\(location)"
        }
        
        if countryId != "" && searchPlacesString.last! != "?"{
            searchPlacesString += "&countryIds=\(countryId)"
        }
        else if countryId != ""{
            searchPlacesString += "countryIds=\(countryId)"
        }
        
        if type != "" && searchPlacesString.last! != "?"{
            searchPlacesString += "&types=\(type)"
        }
        else if type != ""{
            searchPlacesString += "types=\(type)"
        }
        
        if timezoneId != "" && searchPlacesString.last! != "?"{
            searchPlacesString += "&timeZoneIds=\(timezoneId)"
        }
        else if timezoneId != ""{
            searchPlacesString += "timeZoneIds=\(timezoneId)"
        }
        
        if prefix != "" && searchPlacesString.last! != "?"{
            searchPlacesString += "&namePrefix=\(prefix)"
        }
        else if prefix != ""{
            searchPlacesString += "namePrefix=\(prefix)"
        }
        
        if languageCode != "" && searchPlacesString.last! != "?"{
            searchPlacesString += "&languageCode=\(languageCode)"
        }
        else if languageCode != ""{
            searchPlacesString += "languageCode=\(languageCode)"
        }
    }
    
    func fetchPlaces(){
        formString()
        
        guard let url = URL(string: searchPlacesString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> Places in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let places = try? decoder.decode(Places.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return places
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] places in
                self?.places = places
            }
            .store(in: &bag)
    }
}

extension PlacesViewModel{
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
