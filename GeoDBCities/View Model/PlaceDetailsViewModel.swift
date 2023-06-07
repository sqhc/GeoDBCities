//
//  PlaceDetailsViewModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/7/23.
//

import Foundation
import Combine

class PlaceDetailsViewModel: ObservableObject{
    let placeId: String
    
    var searchPlaceDetailsString = "https://wft-geo-db.p.rapidapi.com/v1/geo/places/"
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
    ]
    
    @Published var placeDetail: CityDetailContainer?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(id: String){
        self.placeId = id
    }
    
    func fetchPlaceDetails(){
        searchPlaceDetailsString += placeId
        
        guard let url = URL(string: searchPlaceDetailsString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> CityDetailContainer in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let details = try? decoder.decode(CityDetailContainer.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return details
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] detail in
                self?.placeDetail = detail
            }
            .store(in: &bag)
    }
}
extension PlaceDetailsViewModel{
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
