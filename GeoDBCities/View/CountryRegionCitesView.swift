//
//  CountryRegionCitesView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/2/23.
//

import SwiftUI

struct CountryRegionCitesView: View {
    @ObservedObject var vm: CountryRegionCitiesViewModel
    
    var body: some View {
        ZStack{
            if let cities = vm.regionCities?.data{
                List(cities, id:\.id){ city in
                    CountryRegionCityItem(city: city)
                }
                .listStyle(.plain)
                .navigationBarTitle("\(vm.regionCode)'s cities")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchCountryRegionCities)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct CountryRegionCityItem: View{
    var city: CountryPlace
    var body: some View{
        VStack(alignment: .leading){
            Text("Name: \(city.name ?? "")")
            Text("Type: \(city.type ?? "")")
            Text("Latitude: \(city.latitude ?? 0.0) Longitude: \(city.longitude ?? 0.0)")
            Text("Population: \(city.population ?? 0)")
        }
    }
}

struct CountryRegionCitesView_Previews: PreviewProvider {
    static var previews: some View {
        CountryRegionCitesView(vm: CountryRegionCitiesViewModel(code: "", id: ""))
    }
}
