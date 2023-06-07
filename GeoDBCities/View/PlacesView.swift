//
//  PlacesView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/6/23.
//

import SwiftUI

struct PlacesView: View {
    @StateObject var vm: PlacesViewModel
    @State var showed = false
    
    var body: some View {
        ZStack{
            if let places = vm.places?.data{
                List(places, id:\.id){ place in
                    VStack(alignment: .leading){
                        Text("Name: \(place.name ?? "")")
                        NavigationLink("Details") {
                            PlaceDetailsView(vm: PlaceDetailsViewModel(id: place.wikiDataId ?? ""))
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Places")
            }
            else{
                ProgressView()
            }
        }
        .onAppear {
            guard !showed else {return}
            showed.toggle()
            vm.fetchPlaces()
        }
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView(vm: PlacesViewModel())
    }
}
