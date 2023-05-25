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
