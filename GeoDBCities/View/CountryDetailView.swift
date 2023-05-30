//
//  CountryDetailView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/28/23.
//

import SwiftUI

struct CountryDetailView: View {
    @StateObject var vm: CountryDetailViewModel
    @State var showed = false
    
    var body: some View {
        ZStack{
            if let detail = vm.detail?.data{
                VStack(alignment: .leading){
                    AsyncImage(url: URL(string: detail.flagImageUri ?? ""))
                    Text("Name: \(detail.name ?? "") Capital: \(detail.capital ?? "")")
                    Text("Calling code: \(detail.callingCode ?? "") Region amount: \(detail.numRegions ?? 0)")
                    NavigationLink("Places") {
                        CountryPlacesView(vm: CountryPlacesViewModel(id: detail.code ?? ""))
                    }
                    if let codes = detail.currencyCodes{
                        Section {
                            List(codes, id:\.self){ code in
                                Text(code)
                            }
                        } header: {
                            Text("Currency codes")
                        }
                    }
                }
                .navigationTitle("Country detail")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            guard !showed else { return }
            showed.toggle()
            vm.fetchDetail()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct CountryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CountryDetailView(vm: CountryDetailViewModel(id: ""))
    }
}
