//
//  CitiesNearCityView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/6/23.
//

import SwiftUI

struct CitiesNearCityView: View {
    @ObservedObject var vm: CitiesNearCityViewModel
    
    var body: some View {
        ZStack{
            if let nearCities = vm.nearbyCities?.data{
                List(nearCities, id:\.id){ nearCity in
                    NeaarCityItem(nearCity: nearCity)
                }
                .listStyle(.plain)
                .navigationTitle("Nearby Cities")
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchNearbyCities)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct NeaarCityItem: View{
    var nearCity: CityNearby
    var body: some View{
        VStack(alignment: .leading){
            Text("Name: \(nearCity.name ?? "")")
            Text("Type: \(nearCity.type ?? "")")
            Text("Country: \(nearCity.country ?? "")")
            Text("Region: \(nearCity.region ?? "")")
            Text("Latitude: \(nearCity.latitude ?? 0.0) Longitude: \(nearCity.longitude ?? 0.0)")
            Text("Population: \(nearCity.population ?? 0)")
            Text("Distance: \(nearCity.distance ?? 0.0) Mi")
        }
    }
}

struct CitiesNearCityView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesNearCityView(vm: CitiesNearCityViewModel(id: ""))
    }
}
