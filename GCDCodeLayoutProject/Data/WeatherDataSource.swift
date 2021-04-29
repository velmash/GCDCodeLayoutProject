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
     
     let urlStr = "https://www.metaweather.com/api/location/"
     let imgUrlStr = "https://www.metaweather.com/static/img/weather/png/"
     
     let apiQueue = DispatchQueue(label: "ApiQueue")
     let group = DispatchGroup()
     
     private(set) var region: [Region] = []
     private(set) var info: [Weather] = []
     private(set) var images: [Data] = []
}


//MARK: - Weather Data Fetch
extension WeatherDataSource {
     
     func fetch(urlStr: String) {
          self.group.enter()
          apiQueue.async {
               guard let weatherURL = URL(string: urlStr + "search/?query=se") else {
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
                    let url = urlStr + String(woeid.woeid)
                    
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
                         self.info.append(contentsOf: decodedData.consolidate)
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
