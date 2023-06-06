//
//  CityDetailView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/5/23.
//

import SwiftUI

struct CityDetailView: View {
    @StateObject var vm: CityDetailViewModel
    @State var showed = false
    @State var showLocated = false
    @State var showDateTime = false
    
    var body: some View {
        ZStack{
            if let detail = vm.cityDetail?.data{
                VStack(alignment: .leading) {
                    CityDetailItem(detail: detail)
                    HStack{
                        Button {
                            showLocated.toggle()
                        } label: {
                            Text("City located")
                        }
                        .background(Color.purple)
                        .foregroundColor(.white)
                        .sheet(isPresented: $showLocated) {
                            CityLocatedView(vm: CityLocatedViewModel(id: detail.wikiDataId ?? ""))
                        }
                        .tag("Located")
                        
                        Button {
                            showDateTime.toggle()
                        } label: {
                            Text("Date time")
                        }
                        .background(Color.brown)
                        .foregroundColor(.white)
                        .sheet(isPresented: $showDateTime) {
                            CityDateTimeView(vm: CityDateTimeViewModel(id: detail.wikiDataId ?? ""))
                        }
                        .tag("DateTime")
                    }
                    
                    NavigationLink("Nearby cities") {
                        CitiesNearCityView(vm: CitiesNearCityViewModel(id: detail.wikiDataId ?? ""))
                    }
                }
                .navigationTitle("\(detail.name ?? "")'s details")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            guard !showed else{ return }
            showed.toggle()
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

struct CityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CityDetailView(vm: CityDetailViewModel(id: ""))
    }
}
