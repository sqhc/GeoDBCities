//
//  CountriesView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/28/23.
//

import SwiftUI

struct CountriesView: View {
    @StateObject var vm: CountriesViewModel
    @State var showed = false
    
    var body: some View {
        ZStack{
            if let countries = vm.countries?.data{
                List(countries, id:\.wikiDataId){ country in
                    CountryItem(country: country)
                }
                .listStyle(.plain)
                .navigationTitle("Countries")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            guard !showed else { return }
            showed.toggle()
            vm.fetchCountries()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}


struct CountryItem: View{
    var country: Country
    var body: some View{
        VStack(alignment: .leading){
            Text("Name: \(country.name ?? "")")
            if let codes = country.currencyCodes{
                Section {
                    List(codes, id:\.self){ code in
                        Text(code)
                    }
                } header: {
                    Text("Currency codes")
                }
                .frame(width: 400, height: 50)
            }
            NavigationLink("Details") {
                CountryDetailView(vm: CountryDetailViewModel(id: country.code ?? ""))
            }
        }
    }
}

struct CountriesView_Previews: PreviewProvider {
    static var previews: some View {
        CountriesView(vm: CountriesViewModel())
    }
}
