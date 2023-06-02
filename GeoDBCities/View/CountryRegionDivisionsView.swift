//
//  CountryRegionDivisionsView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/2/23.
//

import SwiftUI

struct CountryRegionDivisionsView: View {
    @ObservedObject var vm: CountryRegionDivisionsViewModel
    
    var body: some View {
        ZStack{
            if let divisions = vm.regionDivisions?.data{
                List(divisions, id:\.id){ division in
                    CountryRegionDivisionItem(division: division)
                }
                .listStyle(.plain)
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchCountryRegionDivisions)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct CountryRegionDivisionItem: View{
    var division: CountryPlace
    var body: some View{
        VStack(alignment: .leading){
            Text("Admin name: \(division.name ?? "")")
            Text("Latitude: \(division.latitude ?? 0.0) Longitude: \(division.longitude ?? 0.0)")
            Text("Population: \(division.population ?? 0)")
        }
    }
}

struct CountryRegionDivisionsView_Previews: PreviewProvider {
    static var previews: some View {
        CountryRegionDivisionsView(vm: CountryRegionDivisionsViewModel(code: "", id: ""))
    }
}
