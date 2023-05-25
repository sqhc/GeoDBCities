//
//  AdminsViewModel.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/25/23.
//

import Foundation
import Combine

class AdminsViewModel: ObservableObject{
    let location: String
    let countryCode: String
    
    var searchAdminsString = "https://wft-geo-db.p.rapidapi.com/v1/geo/adminDivisions"
    let headers = [
        "X-RapidAPI-Key": "54217155a0mshc59ae06a0968327p12a4c1jsn682bd9007ac0",
        "X-RapidAPI-Host": "wft-geo-db.p.rapidapi.com"
    ]
    
    @Published var admins: Admins?
    @Published var hasError = false
    @Published var error: LoadError?
    
    private var bag: Set<AnyCancellable> = []
    
    init(location: String = "", countryCode: String = ""){
        self.location = location
        self.countryCode = countryCode
    }
    
    func fetchAdmins(){
        if location != "" && countryCode != ""{
            searchAdminsString += "?location=\(location)&countryIds=\(countryCode)"
        }
        else if location != ""{
            searchAdminsString += "?location=\(location)"
        }
        else if countryCode != ""{
            searchAdminsString += "?countryIds=\(countryCode)"
        }
        
        guard let url = URL(string: searchAdminsString) else{
            hasError = true
            error = .failedToUnwrapOptional
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .tryMap { result -> Admins in
                guard let response = result.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else{
                          throw LoadError.invalidStatusCode
                      }
                
                let decoder = JSONDecoder()
                guard let admins = try? decoder.decode(Admins.self, from: result.data) else{
                    throw LoadError.failedToDecode
                }
                return admins
            }
            .sink { [weak self] result in
                switch result{
                case .finished:
                    break
                case .failure(let error):
                    self?.hasError = true
                    self?.error = .custom(error: error)
                }
            } receiveValue: { [weak self] admins in
                self?.admins = admins
            }
            .store(in: &bag)
    }
}
extension AdminsViewModel{
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
