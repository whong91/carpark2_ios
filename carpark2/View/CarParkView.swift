//
//  CarParkView.swift
//  carpark2
//
//  Created by Wai Hong Lee on 25/08/2023.
//

import SwiftUI

struct CarParkView: View {
    
    @ObservedObject private var viewModel = CarParkViewModel()
    
    var body: some View {
        
        VStack {
            if viewModel.data != nil {
                Spacer()
                Group{
                    Text("SMALL")
                        .bold()
                    Text("HIGHEST (\(viewModel.smallHighestCarParkLot ?? "-") lots available)")
                    Text(viewModel.smallHighestCarParks.joined(separator: ", "))
                    Text("LOWEST (\(viewModel.smallLowestCarParkLot ?? "-") lots available)")
                    Text(viewModel.smallLowestCarParks.joined(separator: ", "))
                    Text("----------")
                }
                Spacer()
                Group{
                    Text("MEDIUM")
                        .bold()
                    Text("HIGHEST (\(viewModel.mediumHighestCarParkLot ?? "-") lots available)")
                    Text(viewModel.mediumHighestCarParks.joined(separator: ", "))
                    Text("LOWEST (\(viewModel.mediumLowestCarParkLot ?? "-") lots available)")
                    Text(viewModel.mediumLowestCarParks.joined(separator: ", "))
                    Text("----------")
                }
                Spacer()
                Group{
                    Text("BIG")
                        .bold()
                    Text("HIGHEST (\(viewModel.bigHighestCarParkLot ?? "-") lots available)")
                    Text(viewModel.bigHighestCarParks.joined(separator: ", "))
                    Text("LOWEST (\(viewModel.bigLowestCarParkLot ?? "-") lots available)")
                    Text(viewModel.bigLowestCarParks.joined(separator: ", "))
                    Text("----------")
                }
                Spacer()
                Group{
                    Text("LARGE")
                        .bold()
                    Text("HIGHEST (\(viewModel.largeHighestCarParkLot ?? "-") lots available)")
                    Text(viewModel.largeHighestCarParks.joined(separator: ", "))
                    Text("LOWEST (\(viewModel.largeLowestCarParkLot ?? "-") lots available)")
                    Text(viewModel.largeLowestCarParks.joined(separator: ", "))
                }
                Spacer()
                
                    
            } else {
                ProgressView("Loading data…")
            }
        }
        .task {
            while true {
                await viewModel.fetchData()
                await Task.sleep(60_000_000_000)
            }
        }
    }
}

struct CarParkView_Previews: PreviewProvider {
    static var previews: some View {
        CarParkView()
    }
}
