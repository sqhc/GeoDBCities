//
//  CitiesView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/4/23.
//

import SwiftUI

struct CitiesView: View {
    @StateObject var vm: CitiesViewModel
    
    var body: some View {
        ZStack{
            if let cities = vm.cities?.data{
                List(cities, id:\.id){ city in
                    VStack(alignment: .leading){
                        Text("Name: \(city.name ?? "")")
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Cities search result")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            vm.fetchCities()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }

        }
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView(vm: CitiesViewModel())
    }
}
