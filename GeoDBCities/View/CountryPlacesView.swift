//
//  CountryPlacesView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/30/23.
//

import SwiftUI

struct CountryPlacesView: View {
    @ObservedObject var vm: CountryPlacesViewModel
    
    var body: some View {
        ZStack{
            if let places = vm.places?.data{
                List(places, id:\.id){ place in
                    CountryPlacesItem(place: place)
                }
                .navigationTitle("\(vm.countryId)'s places")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchPlaces)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct CountryPlacesItem: View{
    var place: CountryPlace
    var body: some View{
        VStack(alignment: .leading){
            Text("Name: \(place.name ?? "")")
            Text("Type: \(place.type ?? "")")
            Text("Region: \(place.region ?? "")")
            Text("Latitude: \(place.latitude ?? 0.0) Longitude: \(place.longitude ?? 0.0)")
            Text("Pouplation: \(place.population ?? 0)")
        }
    }
}

struct CountryPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        CountryPlacesView(vm: CountryPlacesViewModel(id: ""))
    }
}
