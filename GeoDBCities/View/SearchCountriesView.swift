//
//  SearchCountriesView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/28/23.
//

import SwiftUI

struct SearchCountriesView: View {
    @State var currencyCode = ""
    
    var body: some View {
        ZStack{
            VStack{
                TextField("Currency code", text: $currencyCode)
                    .frame(width: 400, height: 50)
                    .background(Color.gray.opacity(0.3).cornerRadius(20))
                    .padding(10)
                NavigationLink("Search countries") {
                    CountriesView(vm: CountriesViewModel(code: currencyCode))
                }
            }
            .navigationTitle("Search for countries")
        }
    }
}

struct SearchCountriesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCountriesView()
    }
}
