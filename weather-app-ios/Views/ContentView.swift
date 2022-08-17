//
//  ContentView.swift
//  weather-app-ios
//
//  Created by Prayag Gediya on 15/08/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataVM: DataViewModel
    @ObservedObject var locationVM = LocationViewModel()

    init() {
        _dataVM = StateObject(wrappedValue: DataViewModel(service: DataService()))
        if let lat = locationVM.lat, let long = locationVM.long {
            dataVM.fetchData(lat: lat, long: long)
        }
    }

    var body: some View {
        VStack {
            if let data = dataVM.weatherData {
                ScrollView {
                    ForEach(data.list, id: \.name) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text("Min Temp.")
                                Text(item.main.temp_min.description)
                            }
                            VStack(alignment: .leading) {
                                Text("Max Temp.")
                                Text(item.main.temp_max.description)
                            }
                        }
                    }
                }.padding()
            } else {
                Text("Data is being fetched")
            }
        }.onChange(of: locationVM.long) { newValue in
            if let lat = locationVM.lat, let long = locationVM.long {
                dataVM.fetchData(lat: lat, long: long)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
