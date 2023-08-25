//
//  CarParkViewModel.swift
//  carpark2
//
//  Created by Wai Hong Lee on 25/08/2023.
//

import Foundation
import Combine

class CarParkViewModel : ObservableObject {
    
    let url = URL(string: "https://api.data.gov.sg/v1/transport/carpark-availability")
    @Published var data : CarParkReponse?
    
    @Published var smallHighestCarParks : [String] = []
    @Published var smallHighestCarParkLot : String? = ""
    @Published var smallLowestCarParks : [String] = []
    @Published var smallLowestCarParkLot : String? = ""
    @Published var mediumHighestCarParks : [String] = []
    @Published var mediumHighestCarParkLot : String? = ""
    @Published var mediumLowestCarParks : [String] = []
    @Published var mediumLowestCarParkLot : String? = ""
    @Published var bigHighestCarParks : [String] = []
    @Published var bigHighestCarParkLot : String? = ""
    @Published var bigLowestCarParks : [String] = []
    @Published var bigLowestCarParkLot : String? = ""
    @Published var largeHighestCarParks : [String] = []
    @Published var largeHighestCarParkLot : String? = ""
    @Published var largeLowestCarParks : [String] = []
    @Published var largeLowestCarParkLot : String? = ""
    
    
    func fetchData() async {
        await MainActor.run{
            self.data = nil
            
            self.smallHighestCarParks.removeAll()
            self.smallHighestCarParkLot = ""
            self.smallLowestCarParks.removeAll()
            self.smallLowestCarParkLot = ""
            self.mediumHighestCarParks.removeAll()
            self.mediumHighestCarParkLot = ""
            self.mediumLowestCarParks.removeAll()
            self.mediumLowestCarParkLot = ""
            self.bigHighestCarParks.removeAll()
            self.bigHighestCarParkLot = ""
            self.bigLowestCarParks.removeAll()
            self.bigLowestCarParkLot = ""
            self.largeHighestCarParks.removeAll()
            self.largeHighestCarParkLot = ""
            self.largeLowestCarParks.removeAll()
            self.largeLowestCarParkLot = ""
        }
        
        URLSession.shared.dataTask(with: url!) {data, res, error in
            
            guard let data = data else {
                  return
            }
            
            do {
                let carparkResponse = try JSONDecoder().decode(CarParkReponse.self, from: data)
                let response = carparkResponse.items.first
                guard(response != nil) else {
                    return
                }

                var smallCarParks : [CarparkData] = []
                var mediumCarParks : [CarparkData] = []
                var bigCarParks : [CarparkData] = []
                var largeCarParks : [CarparkData] = []

                for carpark in response!.carParkData{

                    var totalLot = 0
                    for carparkInfo in carpark.carparkInfo{
                        totalLot += Int(carparkInfo.totalLots) ?? 0
                    }

                    if(totalLot < 100){
                        smallCarParks.append(carpark)
                    }else if(totalLot >= 100 && totalLot < 300){
                        mediumCarParks.append(carpark)
                    }else if(totalLot >= 300 && totalLot < 400){
                        bigCarParks.append(carpark)
                    }else if(totalLot >= 400){
                        largeCarParks.append(carpark)
                    }

                }

                var smallHighestLot = Int.min
                var smallLowestLot = Int.max

                for carpark in smallCarParks {
                    var availableLot = 0
                    for carparkInfo in carpark.carparkInfo{
                        availableLot += Int(carparkInfo.lotsAvailable) ?? 0
                    }

                    if(availableLot < smallLowestLot){
                        smallLowestLot = availableLot
                        self.smallLowestCarParks.removeAll()
                        self.smallLowestCarParks.append(carpark.carparkNumber)
                    }else if(availableLot == smallLowestLot){
                        self.smallLowestCarParks.append(carpark.carparkNumber)
                    }

                    if(availableLot > smallHighestLot){
                        smallHighestLot = availableLot
                        self.smallHighestCarParks.removeAll()
                        self.smallHighestCarParks.append(carpark.carparkNumber)
                    } else if(availableLot == smallHighestLot){
                        self.smallHighestCarParks.append(carpark.carparkNumber)
                    }
                }
                self.smallHighestCarParkLot = String(smallHighestLot)
                self.smallLowestCarParkLot = String(smallLowestLot)


                var mediumHighestLot = Int.min
                var mediumLowestLot = Int.max

                for carpark in mediumCarParks {
                    var availableLot = 0
                    for carparkInfo in carpark.carparkInfo{
                        availableLot += Int(carparkInfo.lotsAvailable) ?? 0
                    }

                    if(availableLot < mediumLowestLot){
                        mediumLowestLot = availableLot
                        self.mediumLowestCarParks.removeAll()
                        self.mediumLowestCarParks.append(carpark.carparkNumber)
                    }else if(availableLot == mediumLowestLot){
                        self.mediumLowestCarParks.append(carpark.carparkNumber)
                    }

                    if(availableLot > mediumHighestLot){
                        mediumHighestLot = availableLot
                        self.mediumHighestCarParks.removeAll()
                        self.mediumHighestCarParks.append(carpark.carparkNumber)
                    } else if(availableLot == mediumHighestLot){
                        self.mediumHighestCarParks.append(carpark.carparkNumber)
                    }
                }
                self.mediumHighestCarParkLot = String(mediumHighestLot)
                self.mediumLowestCarParkLot = String(mediumLowestLot)


                var bigHighestLot = Int.min
                var bigLowestLot = Int.max

                for carpark in bigCarParks {
                    var availableLot = 0
                    for carparkInfo in carpark.carparkInfo{
                        availableLot += Int(carparkInfo.lotsAvailable) ?? 0
                    }

                    if(availableLot < bigLowestLot){
                        bigLowestLot = availableLot
                        self.bigLowestCarParks.removeAll()
                        self.bigLowestCarParks.append(carpark.carparkNumber)
                    }else if(availableLot == bigLowestLot){
                        self.bigLowestCarParks.append(carpark.carparkNumber)
                    }

                    if(availableLot > bigHighestLot){
                        bigHighestLot = availableLot
                        self.bigHighestCarParks.removeAll()
                        self.bigHighestCarParks.append(carpark.carparkNumber)
                    } else if(availableLot == bigHighestLot){
                        self.bigHighestCarParks.append(carpark.carparkNumber)
                    }
                }
                self.bigHighestCarParkLot = String(bigHighestLot)
                self.bigLowestCarParkLot = String(bigLowestLot)


                var largeHighestLot = Int.min
                var largeLowestLot = Int.max

                for carpark in largeCarParks {
                    var availableLot = 0
                    for carparkInfo in carpark.carparkInfo{
                        availableLot += Int(carparkInfo.lotsAvailable) ?? 0
                    }

                    if(availableLot < largeLowestLot){
                        largeLowestLot = availableLot
                        self.largeLowestCarParks.removeAll()
                        self.largeLowestCarParks.append(carpark.carparkNumber)
                    }else if(availableLot == largeLowestLot){
                        self.largeLowestCarParks.append(carpark.carparkNumber)
                    }

                    if(availableLot > largeHighestLot){
                        largeHighestLot = availableLot
                        self.largeHighestCarParks.removeAll()
                        self.largeHighestCarParks.append(carpark.carparkNumber)
                    } else if(availableLot == largeHighestLot){
                        self.largeHighestCarParks.append(carpark.carparkNumber)
                    }
                }
                self.largeHighestCarParkLot = String(largeHighestLot)
                self.largeLowestCarParkLot = String(largeLowestLot)
                self.data = carparkResponse
                
                
            } catch {
                print("Something went wrong.")
            }


        }.resume()
            
        
        
        
        
    }
    
}
