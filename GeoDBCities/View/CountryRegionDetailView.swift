//
//  CountryRegionDetailView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/30/23.
//

import SwiftUI

struct CountryRegionDetailView: View {
    @StateObject var vm: CountryRegionDetailViewModel
    
    var body: some View {
        ZStack{
            if let detail = vm.regionDetail?.data{
                VStack(alignment: .leading){
                    Text("Name: \(detail.name ?? "")")
                    Text("Region capital: \(detail.capital ?? "")")
                    Text("Number of cities: \(detail.numCities ?? 0)")
                    Text("Number of places: \(detail.numPlaces ?? 0)")
                }
                .navigationTitle("\(detail.name ?? "")'s detail")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
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
