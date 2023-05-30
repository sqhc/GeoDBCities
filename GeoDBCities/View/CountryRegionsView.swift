//
//  CountryRegionsView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/30/23.
//

import SwiftUI

struct CountryRegionsView: View {
    @StateObject var vm: CountryRegionsViewModel
    
    var body: some View {
        ZStack{
            if let regions = vm.regions?.data{
                List(regions, id:\.fipsCode){ region in
                    CountryRegionItem(region: region)
                }
                .navigationTitle("\(vm.countryId)'s regions")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchRegions()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct CountryRegionItem: View{
    var region : CountryRegion
    var body: some View{
        VStack(alignment: .leading){
            Text("Name: \(region.name ?? "")")
        }
    }
}

struct CountryRegionsView_Previews: PreviewProvider {
    static var previews: some View {
        CountryRegionsView(vm: CountryRegionsViewModel(id: ""))
    }
}
