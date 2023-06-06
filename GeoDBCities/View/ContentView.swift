//
//  ContentView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 5/25/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack{
                NavigationLink("Search admins") {
                    SearchAdminsView()
                }
                .frame(width: 300, height: 50, alignment: .center)
                .background(Color.red)
                .cornerRadius(10)
                
                Divider()
                
                NavigationLink {
                    SearchCountriesView()
                } label: {
                    Text("Search countries")
                        .foregroundColor(.white)
                }
                .frame(width: 300, height: 50, alignment: .center)
                .background(Color.blue)
                .cornerRadius(10)
                
                Divider()
                
                NavigationLink {
                    SearchCitiesView()
                } label: {
                    Text("Search cities")
                        .foregroundColor(.white)
                }
                .frame(width: 300, height: 50, alignment: .center)
                .background(Color.green)
                .cornerRadius(10)
                
                Divider()
                
                NavigationLink {
                    SearchPlacesView()
                } label: {
                    Text("Search places")
                        .foregroundColor(.white)
                }
                .frame(width: 300, height: 50, alignment: .center)
                .background(Color.black)
                .cornerRadius(10)
            }
            .navigationTitle("Search options")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
