//
//  NearAdminsViewModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/26/23.
//

import Foundation
import Combine

class NearAdminsViewModel: ObservableObject{
    let divisionId: String
    
    var searchNearAdminsString = "https://wft-geo-db.p.rapidapi.com/v1/geo/adminDivisions/"
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
    ]
    
    @Published var nearAdmins: NearAdmins?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(id: String){
        self.divisionId = id
    }
    
    func fetchNearAdmins(){
        searchNearAdminsString += "\(divisionId)/nearbyDivisions?radius=100"
        
        guard let url = URL(string: searchNearAdminsString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> NearAdmins in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                let decoder = JSONDecoder()
                guard let nearAdmins = try? decoder.decode(NearAdmins.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return nearAdmins
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] near in
                self?.nearAdmins = near
            }
            .store(in: &bag)
    }
}

extension NearAdminsViewModel{
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
