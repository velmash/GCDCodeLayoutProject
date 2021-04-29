//
//  Weather.swift
//  GCDCodeLayoutProject
//
//  Created by 윤형찬 on 2021/04/29.
//

import Foundation

struct Weather: Codable {
     let name: String
     let abbr: String
     let date: String
     let temp: Double
     let humidity: Int
     
     enum CodingKeys: String, CodingKey {
          case name = "weather_state_name"
          case abbr = "weather_state_abbr"
          case date = "applicable_date"
          case temp = "the_temp"
          
          case humidity
     }
}

struct Information: Codable {
     let consolidate: [Weather]
     
     enum CodingKeys: String, CodingKey {
          case consolidate = "consolidated_weather"
     }
}
