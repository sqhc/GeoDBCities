//
//  AdminsView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/25/23.
//

import SwiftUI

struct AdminsView: View {
    @StateObject var vm: AdminsViewModel
    
    var body: some View {
        ZStack{
            if let admins = vm.admins?.data{
                List(admins, id: \.id){ admin in
                    AdminItem(admin: admin)
                }
                .listStyle(.plain)
                .navigationTitle("Admin divisions")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchAdmins()
        }
    }
}

struct AdminsView_Previews: PreviewProvider {
    static var previews: some View {
        AdminsView(vm: AdminsViewModel(location: "", countryCode: ""))
    }
}

struct AdminItem: View{
    let admin: Admin
    var body: some View{
        VStack(alignment: .leading){
            Text("Admin name: \(admin.name ?? "")")
            Text("Country: \(admin.country ?? "")")
            Text("Region: \(admin.region ?? "")")
            Text("Population: \(admin.population ?? 0)")
        }
    }
}
