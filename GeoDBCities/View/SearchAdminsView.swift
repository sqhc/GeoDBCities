//
//  SearchAdminsView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/25/23.
//

import SwiftUI

struct SearchAdminsView: View {
    @State var countryCode = ""
    @StateObject var manager = LocationManager.shared
    @State var locationStr = ""
    
    var body: some View {
        ZStack{
            VStack{
                TextField("Country Code", text: $countryCode)
                    .frame(width: 400, height: 50)
                    .background(Color.gray.opacity(0.3).cornerRadius(20))
                    .padding(10)
                NavigationLink("Search admin divisions") {
                    AdminsView(vm: AdminsViewModel( countryCode: countryCode))
                }
                Divider()
                NavigationLink {
                    AdminsView(vm: AdminsViewModel(location: locationStr))
                } label: {
                    HStack {
                        Image(systemName: "location.fill")
                        Text("Search with your current location")
                    }
                }

            }
            .navigationTitle("Search for admins")
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

struct SearchAdminsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAdminsView()
    }
}
