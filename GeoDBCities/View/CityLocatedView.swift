//
//  CityLocatedView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/5/23.
//

import SwiftUI

struct CityLocatedView: View {
    @ObservedObject var vm : CityLocatedViewModel
    
    var body: some View {
        ZStack{
            if let detail = vm.locatedDetail?.data{
                CityDetailItem(detail: detail)
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchLocated)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct CityLocatedView_Previews: PreviewProvider {
    static var previews: some View {
        CityLocatedView(vm: CityLocatedViewModel(id: ""))
    }
}
