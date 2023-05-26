//
//  AdminsView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/25/23.
//

import SwiftUI

struct AdminsView: View {
    @StateObject var vm: AdminsViewModel
    @State var showed = false
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
            guard !showed else { return }
            showed.toggle()
            vm.fetchAdmins()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
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
    @State var showNear = false
    var body: some View{
        VStack(alignment: .leading){
            Text("Admin name: \(admin.name ?? "")")
            Text("Country: \(admin.country ?? "")")
            Text("Region: \(admin.region ?? "")")
            Text("Population: \(admin.population ?? 0)")
            HStack(spacing: 20){
                Button {
                    showNear.toggle()
                } label: {
                    Text("Near admins")
                        .frame(width: 100)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(20)
                }
                .sheet(isPresented: $showNear) {
                    NearAdminsView(vm: NearAdminsViewModel(id: admin.wikiDataId ?? ""))
                }
            }
        }
    }
}
