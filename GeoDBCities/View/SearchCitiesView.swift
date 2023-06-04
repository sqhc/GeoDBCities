//
//  SearchCitiesView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/4/23.
//

import SwiftUI

struct SearchCitiesView: View {
    @State var countryID = ""
    @StateObject var manager = LocationManager.shared
    @State var locationStr = ""
    
    var body: some View {
        ZStack{
            VStack{
                TextField("Country Id", text: $countryID)
                    .frame(width: 400, height: 50)
                    .background(Color.gray.opacity(0.3).cornerRadius(20))
                    .padding(10)
                NavigationLink("Search cities") {
                    CitiesView(vm: CitiesViewModel(id: countryID))
                }
                Divider()
                NavigationLink {
                    CitiesView(vm: CitiesViewModel(location: locationStr))
                } label: {
                    HStack {
                        Image(systemName: "location.fill")
                        Text("Search with your current location")
                    }
                }
            }
            .navigationTitle("Search for cities")
        }
        .onAppear(perform: formLocationStr)
    }
    
    private func formLocationStr(){
        guard let latitude = manager.manager.location?.coordinate.latitude, let longitude = manager.manager.location?.coordinate.longitude else{
            return
        }
        if longitude > 0{
            locationStr = "\(latitude)+\(longitude)"
        }
        else{
            locationStr = "\(latitude)\(longitude)"
        }
    }
}

struct SearchCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCitiesView()
    }
}
