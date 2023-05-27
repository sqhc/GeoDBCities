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
            }
            .navigationTitle("Search for admins")
        }
    }
}

struct SearchAdminsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchAdminsView()
    }
}
