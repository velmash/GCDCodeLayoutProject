//
//  ViewFunctions.swift
//  GCDCodeLayoutProject
//
//  Created by 윤형찬 on 2021/04/29.
//

import Foundation
import UIKit

// MARK: - Image 추출
extension ViewController {
     func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
          URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
     }
     
     func downloadImage(from url: URL, cell: MainTableViewCell) {
          getData(from: url) { data, response, error in
               guard let data = data, error == nil else {
                    return
               }
               DispatchQueue.main.async() {
                    cell.todayImage.image = UIImage(data: data)
                    cell.tomorrowImage.image = UIImage(data: data)
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
          self.weather.fetch(urlStr: urlStr)
     }
}
