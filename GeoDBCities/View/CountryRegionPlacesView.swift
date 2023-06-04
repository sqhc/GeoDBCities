//
//  CountryRegionPlacesView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/4/23.
//

import SwiftUI

struct CountryRegionPlacesView: View {
    @ObservedObject var vm: CountryRegionPlacesViewModel
    
    var body: some View {
        ZStack{
            if let places = vm.regionPlaces?.data{
                List(places, id:\.id){ place in
                    CountryRegionPlaceItem(place: place)
                }
                .listStyle(.plain)
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchCountryRegionPlaces)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct CountryRegionPlaceItem: View{
    var place: CountryPlace
    var body: some View{
        VStack(alignment: .leading){
            Text("Place name: \(place.name ?? "")")
            Text("Type: \(place.type ?? "")")
            Text("Latitude: \(place.latitude ?? 0.0) Longitude: \(place.longitude ?? 0.0)")
            Text("Population: \(place.population ?? 0)")
        }
    }
}

struct CountryRegionPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        CountryRegionPlacesView(vm: CountryRegionPlacesViewModel(code: "", id: ""))
    }
}
