//
//  WeatherDataSource.swift
//  GCDCodeLayoutProject
//
//  Created by 윤형찬 on 2021/04/29.
//

import Foundation
import UIKit

class WeatherDataSource {
     //MARK: - Properties
     static let shared = WeatherDataSource()
     static let weatherInfoDidUpdate = Notification.Name(rawValue: "weatherInfoDidUpdate")
     
     let url = "https://www.metaweather.com/"
     
     let apiQueue = DispatchQueue(label: "ApiQueue")
     let group = DispatchGroup()
     
     private(set) var region: [Region] = []
     private(set) var todayInfo: [Weather] = []
     private(set) var tomorrowInfo: [Weather] = []
     
     private(set) var images: [Data] = []
}


//MARK: - Weather Data Fetch
extension WeatherDataSource {
     
     func fetch(query: String) {
          self.group.enter()
          apiQueue.async {
               guard let weatherURL = URL(string: self.url + "/api/location/search/?query=" + query) else {
                    print("Can't not found this URL")
                    return
               }
               
               guard let jsonData = try! String(contentsOf: weatherURL).data(using: .utf8) else {
                    print("Error : string -> Json")
                    return
               }
               
               do {
                    self.region = try JSONDecoder().decode([Region].self, from: jsonData)
                    self.group.leave()
               } catch {
                    print("error trying to convert data to JSON")
               }
          }
          
          apiQueue.async {
               for woeid in self.region {
                    self.group.enter()
                    let url = self.url + "/api/location/\(String(woeid.woeid))"
                    
                    guard let infoURL = URL(string: url) else {
                         print("Can't not found this URL")
                         return
                    }
                    
                    guard let infoData = try! String(contentsOf: infoURL).data(using: .utf8) else {
                         print("Error : string -> Json")
                         return
                    }
                    
                    do {
                         let decodedData = try JSONDecoder().decode(Information.self, from: infoData)
                        
                         var count = 0
                         for i in decodedData.consolidate {
                              if count == 2 {
                                   break
                              } else if count == 0{
                                   self.todayInfo.append(i)
                                   count += 1
                              } else {
                                   self.tomorrowInfo.append(i)
                                   count += 1
                              }
                         }
                         self.group.leave()
                    } catch {
                         print(error)
                    }
               }
          }
          
          self.group.notify(queue: apiQueue) {
               NotificationCenter.default.post(name: Self.weatherInfoDidUpdate, object: nil)
          }
     }
}
