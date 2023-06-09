//
//  CountryRegionDetailView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/30/23.
//

import SwiftUI

struct CountryRegionDetailView: View {
    @StateObject var vm: CountryRegionDetailViewModel
    @State var showed = false
    @State var showCountryRegionCities = false
    @State var showCountryRegionDivisions = false
    @State var showCountryRegionPlaces = false
    
    var body: some View {
        ZStack{
            if let detail = vm.regionDetail?.data{
                VStack(alignment: .leading){
                    Text("Name: \(detail.name ?? "")")
                    Text("Region capital: \(detail.capital ?? "")")
                    Text("Number of cities: \(detail.numCities ?? 0)")
                    Text("Number of places: \(detail.numPlaces ?? 0)")
                    HStack{
                        Button {
                            showCountryRegionCities.toggle()
                        } label: {
                            Text("Cities")
                        }
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .sheet(isPresented: $showCountryRegionCities) {
                            CountryRegionCitesView(vm: CountryRegionCitiesViewModel(code: vm.regionCode, id: vm.countryId))
                        }
                        .tag("CountryRegionCities")
                        
                        Button {
                            showCountryRegionDivisions.toggle()
                        } label: {
                            Text("Divisions")
                        }
                        .background(Color.red)
                        .foregroundColor(.white)
                        .sheet(isPresented: $showCountryRegionDivisions) {
                            CountryRegionDivisionsView(vm: CountryRegionDivisionsViewModel(code: vm.regionCode, id: vm.countryId))
                        }
                        .tag("CountryRegionDivisions")
                        
                        Button {
                            showCountryRegionPlaces.toggle()
                        } label: {
                            Text("Places")
                        }
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .sheet(isPresented: $showCountryRegionPlaces) {
                            CountryRegionPlacesView(vm: CountryRegionPlacesViewModel(code: vm.regionCode, id: vm.countryId))
                        }
                        .tag("CountryRegionPlaces")
                    }
                }
                .navigationTitle("\(detail.name ?? "")'s detail")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            guard !showed else { return }
            showed.toggle()
            vm.fetchRegionDetail()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct CountryRegionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryRegionDetailView(vm: CountryRegionDetailViewModel(id: "", code: ""))
    }
}
