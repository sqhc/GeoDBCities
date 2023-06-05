//
//  CityDateTimeView.swift
//  GeoDBCities
//
//  Created by 沈清昊 on 6/5/23.
//

import SwiftUI

struct CityDateTimeView: View {
    @ObservedObject var vm: CityDateTimeViewModel
    
    var body: some View {
        ZStack{
            if let dateTime = vm.cityDateTime?.data{
                Text(dateTime)
            }
            else{
                ProgressView()
            }
        }
        .onAppear(perform: vm.fetchDateTime)
        .alert(isPresented: $vm.hasError, error: vm.error) {
            Button {
                
            } label: {
                Text("Cancel")
            }
        }
    }
}

struct CityDateTimeView_Previews: PreviewProvider {
    static var previews: some View {
        CityDateTimeView(vm: CityDateTimeViewModel(id: ""))
    }
}
