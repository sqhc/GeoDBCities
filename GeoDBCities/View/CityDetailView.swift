//
//  CityDetailView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/5/23.
//

import SwiftUI

struct CityDetailView: View {
    @StateObject var vm: CityDetailViewModel
    
    var body: some View {
        ZStack{
            if let detail = vm.cityDetail?.data{
                VStack(alignment: .leading) {
                    CityDetailItem(detail: detail)
                }
                .navigationTitle("\(detail.name ?? "")'s details")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchCityDetail()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct CityDetailItem: View{
    var detail: CityDetail
    var body: some View{
        VStack{
            Text("Name: \(detail.name ?? "")")
            Text("Country: \(detail.country ?? "")")
            Text("Region: \(detail.region ?? "")")
            Text("Elevation meters: \(detail.elevationMeters ?? 0)")
            Text("Latitude: \(detail.latitude ?? 0.0) Longitude: \(detail.longitude ?? 0.0)")
            Text("Population: \(detail.population ?? 0)")
            Text("Time zone: \(detail.timezone ?? "")")
        }
    }
}

struct CityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CityDetailView(vm: CityDetailViewModel(id: ""))
    }
}
