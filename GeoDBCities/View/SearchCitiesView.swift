//
//  SearchCitiesView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/4/23.
//

import SwiftUI

struct SearchCitiesView: View {
    @State var countryID = ""
    
    var body: some View {
        ZStack{
            VStack{
                TextField("Country Id", text: $countryID)
                    .frame(width: 400, height: 50)
                    .background(Color.gray.opacity(0.3).cornerRadius(20))
                    .padding(10)
            }
            .navigationTitle("Search for cities")
        }
    }
}

struct SearchCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCitiesView()
    }
}
