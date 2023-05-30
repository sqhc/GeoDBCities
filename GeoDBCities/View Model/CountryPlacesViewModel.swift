//
//  CountryPlacesViewModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/30/23.
//

import Foundation
import Combine

class CountryPlacesViewModel: ObservableObject{
    let countryId : String
    
    var searchCountryPlacesString = "https://wft-geo-db.p.rapidapi.com/v1/geo/countries/"
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
    ]
    
    @Published var places: CountryPlaces?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(id: String){
        self.countryId = id
    }
    
    func fetchPlaces(){
        searchCountryPlacesString += "\(countryId)/places"
        
        guard let url = URL(string: searchCountryPlacesString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> CountryPlaces in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let places = try? decoder.decode(CountryPlaces.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return places
            }
            .sink { [weak self] result in
                switch result{
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] places in
                self?.places = places
            }
            .store(in: &bag)
    }
}
extension CountryPlacesViewModel{
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
