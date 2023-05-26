//
//  NearAdminsView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/26/23.
//

import SwiftUI

struct NearAdminsView: View {
    @ObservedObject var vm: NearAdminsViewModel
    
    var body: some View {
        ZStack{
            if let nears = vm.nearAdmins?.data{
                List(nears, id: \.id){ near in
                    NearAdminItem(near: near)
                }
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchNearAdmins)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct NearAdminItem: View{
    let near: NearAdmin
    
    var body: some View{
        VStack(alignment: .leading){
            Text("Admin name: \(near.name ?? "")")
            Text("Country: \(near.country ?? "")")
            Text("Region: \(near.region ?? "")")
            Text("Population: \(near.population ?? 0)")
            Text("Distance: \(near.distance ?? 0.0) mi")
        }
    }
}

struct NearAdminsView_Previews: PreviewProvider {
    static var previews: some View {
        NearAdminsView(vm: NearAdminsViewModel(id: ""))
    }
}
