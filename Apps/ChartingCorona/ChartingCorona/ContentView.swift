//
//  ContentView.swift
//  ChartingCorona
//
//  Created by Ben Gavan on 31/03/2020.
//  Copyright © 2020 Ben Gavan. All rights reserved.
//

// https://pomber.github.io/covid19/timeseries.json

import SwiftUI

struct TimeSeries: Decodable {
    let US: [DayData]
//    let UK: [DayData]
//    let Italy: [DayData]
}

struct DayData: Decodable, Hashable {
    let date: String
    let confirmed, deaths, recovered: Int
}


class ChartViewModel: ObservableObject {
    
    @Published var dataSet = [DayData]()
    
    var max = 0
    
    init() {
        let urlString =  "https://pomber.github.io/covid19/timeseries.json"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            // TODO: Check the errors
            
            guard let data = data else { return }
            
            do {
                let timeSeries = try JSONDecoder().decode(TimeSeries.self, from: data)
                
                DispatchQueue.main.async {
                    self.dataSet = timeSeries.US.filter { $0.deaths > 0 }
                    self.max = self.dataSet.max(by: { (day1, day2) -> Bool in
                        return day2.deaths > day1.deaths
                        })?.deaths ?? 0
                }
                
                
//                timeSeries.US.forEach { (dayData) in
//                    print(dayData.date, dayData.confirmed, dayData.deaths, Float64(dayData.deaths)/Float64(dayData.confirmed))
//                }
            } catch {
                print("JSON Decode failed:", error)
            }
            
            
        }.resume()
    }
}

struct ContentView: View {
    
    @ObservedObject var vm = ChartViewModel()
    
    var body: some View {
        VStack {
            Text("Corona")
                .font(.system(size: 34, weight: .bold))
            Text("Total Deaths \(self.vm.max)")
            
            if !vm.dataSet.isEmpty {
                ScrollView(.horizontal) {
                    HStack (alignment: .bottom, spacing: 4){
                        ForEach(vm.dataSet, id: \.self) { day in
                            HStack {
                                Spacer()
                            }.frame(width: 8, height: (CGFloat(day.deaths) / CGFloat(self.vm.max)) * 200)
                                .background(Color.red)
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
