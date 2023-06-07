//
//  PlaceDetailsView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/7/23.
//

import SwiftUI

struct PlaceDetailsView: View {
    @State var vm: PlaceDetailsViewModel
    var body: some View {
        ZStack{
            if let detail = vm.placeDetail?.data{
                VStack {
                    PlaceDetailItem(detail: detail)
                }
                .navigationTitle("\(detail.name ?? "")'s details")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchPlaceDetails()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct PlaceDetailItem: View{
    var detail : CityDetail
    var body: some View{
        VStack{
            Text("Name: \(detail.name ?? "")")
            Text("Type: \(detail.type ?? "")")
            Text("Country: \(detail.country ?? "")")
            Text("Region: \(detail.region ?? "")")
            Text("Elevation meters: \(detail.elevationMeters ?? 0)")
            Text("Latitude: \(detail.latitude ?? 0.0) Longitude: \(detail.longitude ?? 0.0)")
            Text("Population: \(detail.population ?? 0)")
            Text("Time zone: \(detail.timezone ?? "")")
        }
    }
}

struct PlaceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailsView(vm: PlaceDetailsViewModel(id: ""))
    }
}
