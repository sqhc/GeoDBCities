//
//  SearchPlacesView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/6/23.
//

import SwiftUI

struct SearchPlacesView: View {
    @State var countryID = ""
    @StateObject var manager = LocationManager.shared
    @State var locationStr = ""
    @State var type = ""
    @State var timeZone = ""
    @State var prefix = ""
    @State var language = ""
    
    var body: some View {
        ZStack{
            VStack{
                VStack(alignment: .leading, spacing: 10.0){
                    Text("Type of place: \(type)")
                    Text("(Long tap to choose)")
                }
                .foregroundColor(.white)
                .padding(20)
                .background(Color.cyan.cornerRadius(20))
                .contextMenu{
                    Button {
                        type = "CITY"
                    } label: {
                        Text("City")
                    }
                    
                    Button {
                        type = "ADM2"
                    } label: {
                        Text("Admin")
                    }

                    Button {
                        type = "ISLAND"
                    } label: {
                        Text("Island")
                    }
                }
                
                TextField("Country Id", text: $countryID)
                    .frame(width: 400, height: 50)
                    .background(Color.gray.opacity(0.3).cornerRadius(20))
                    .padding(10)
                
                TextField("Timezone Id", text: $timeZone)
                    .frame(width: 400, height: 50)
                    .background(Color.green.opacity(0.3).cornerRadius(20))
                    .padding(10)
                
                TextField("Name prefix", text: $prefix)
                    .frame(width: 400, height: 50)
                    .background(Color.red.opacity(0.3).cornerRadius(20))
                    .padding(10)
                
                TextField("Language code", text: $language)
                    .frame(width: 400, height: 50)
                    .background(Color.blue.opacity(0.3).cornerRadius(20))
                    .padding(10)
                
                NavigationLink("Search for places") {
                    PlacesView(vm: PlacesViewModel(id: countryID, type: type, timezone: timeZone, prefix: prefix, languageCode: language))
                }
                
                Divider()
                NavigationLink {
                    PlacesView(vm: PlacesViewModel(location: locationStr, type: type, prefix: prefix))
                } label: {
                    HStack {
                        Image(systemName: "location.fill")
                        Text("Search with your current location")
                    }
                }
            }
            .navigationTitle("Search for places")
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

struct SearchPlacesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchPlacesView()
    }
}
