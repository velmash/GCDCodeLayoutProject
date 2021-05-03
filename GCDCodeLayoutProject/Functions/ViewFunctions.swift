//
//  ViewFunctions.swift
//  GCDCodeLayoutProject
//
//  Created by 윤형찬 on 2021/04/29.
//

import Foundation
import UIKit

// MARK: - Image 추출
extension UIImageView {
     func load(url: String) {
          if let url = URL(string: "https://www.metaweather.com/static/img/weather/png/\(url).png") {
               DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url) {
                         if let image = UIImage(data: data) {
                              DispatchQueue.main.async {
                                   self?.image = image
                              }
                         }
                    }
               }
          }
     }
}


// MARK: - 당겨서 새로고침
extension ViewController {
     func initRefresh() {
          let refresh = UIRefreshControl()
          refresh.addTarget(self, action: #selector(updateUI(refresh:)), for: .valueChanged)
          refresh.tintColor = UIColor.black
          
          indicator.startAnimating()
          
          
          if #available(iOS 10, *) {
               self.weatherTable.refreshControl = refresh
          } else {
               self.weatherTable.addSubview(refresh)
          }
          
          NotificationCenter.default.addObserver(forName: WeatherDataSource.weatherInfoDidUpdate, object: nil, queue: .main) { _ in
               refresh.endRefreshing()
          }
     }
     
     @objc func updateUI(refresh: UIRefreshControl) {
          self.weather.fetch(query: "se")
     }
}
