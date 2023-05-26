//
//  AdminDetailView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/26/23.
//

import SwiftUI

struct AdminDetailView: View {
    @StateObject var vm: AdminDetailViewModel
    
    var body: some View {
        ZStack{
            if let detail = vm.detail?.data{
                VStack(alignment: .leading){
                    Text("Admin: \(detail.name ?? "")")
                    Text("Country: \(detail.country ?? "")")
                    Text("Region: \(detail.region ?? "")")
                    HStack{
                        Text("Latitude: \(detail.latitude ?? 0.0)")
                        Spacer()
                        Text("Longitude: \(detail.longitude ?? 0.0)")
                    }
                    Text("Time zone: \(detail.timezone ?? "")")
                    if let delete = detail.deleted{
                        Text(delete ? "Deleted" : "Still exist")
                    }
                }
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchDetail)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct AdminDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AdminDetailView(vm: AdminDetailViewModel(id: ""))
    }
}
