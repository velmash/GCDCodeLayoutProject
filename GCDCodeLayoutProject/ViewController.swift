//
//  ViewController.swift
//  GCDCodeLayoutProject
//
//  Created by 윤형찬 on 2021/04/29.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
     
     // MARK: - Properties
     @IBOutlet weak var weatherTable: UITableView!
     @IBOutlet weak var indicator: UIActivityIndicatorView!
     
     let weather = WeatherDataSource.shared
     
     
     lazy var localWeather: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.textAlignment = .center
          lbl.font = UIFont.systemFont(ofSize: 40, weight: .bold)
          lbl.lineBreakMode = .byCharWrapping
          lbl.text = "Local Weather"
          view.addSubview(lbl)
          return lbl
     } ()
     
     
     // MARK: - ViewDidLoad
     override func viewDidLoad() {
          super.viewDidLoad()
          // Do any additional setup after loading the view.
          
          weatherTable.alpha = 0.0
          
          
          initRefresh()
          weather.fetch(query: "se")
          setConstraint()
          
          NotificationCenter.default.addObserver(forName: WeatherDataSource.weatherInfoDidUpdate, object: nil, queue: .main) { _ in    // (noti) in
               UIView.animate(withDuration: 0.3) {
                    self.indicator.stopAnimating()
                    self.indicator.alpha = 0
                    
                    self.weatherTable.reloadData()
                    self.weatherTable.alpha = 1.0
                    print(self.weather.info)
               }
          }
     }
}

//MARK: - TableViewDataSource
extension ViewController: UITableViewDataSource {
     func numberOfSections(in tableView: UITableView) -> Int {
          return 2
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          switch section {
          case 0:
               return 1
          case 1:
               return weather.region.count
          default:
               return 0
          }
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          if indexPath.section == 0 {
               let cell = tableView.dequeueReusableCell(withIdentifier: "IndicatorCell", for: indexPath) as! IndicatorTableViewCell
               cell.selectionStyle = .none
               return cell
          } else {
               let cell = self.weatherTable.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
               let imgStr = URL(string: weather.url + "/static/img/weather/png/\(weather.info[indexPath.row].abbr).png")
               
               cell.localName.text = weather.region[indexPath.row].title
               cell.todayWeather.text = weather.info[indexPath.row * 2].name
               cell.todayCelcius.text = "\(Int(round(weather.info[indexPath.row * 2].temp)))°C"
               cell.todayHumadity.text = "\(weather.info[indexPath.row * 2].humidity)%"
               cell.tomorrowWeather.text = weather.info[indexPath.row * 2 + 1].name
               cell.tomorrowCelcius.text = "\(Int(round(weather.info[indexPath.row * 2 + 1].temp)))°C"
               cell.tomorrowHumadity.text = "\(weather.info[indexPath.row * 2 + 1].humidity)%"
               downloadImage(from: imgStr!, cell: cell)
               
               cell.selectionStyle = .none
               return cell
               
          }
     }
}

// MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate {
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          switch indexPath.section {
          case 0:
               return 40
          case 1:
               return 80
          default:
               return 0
          }
     }
}

// MARK: - ViewController 요소 Layout
extension ViewController {
     func setConstraint() {
          indicator.snp.makeConstraints {
               indicator.style = UIActivityIndicatorView.Style.large
               indicator.color = .black
               
               $0.centerX.equalToSuperview()
               $0.centerY.equalToSuperview()
          }
          
          localWeather.snp.makeConstraints {
               $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
               $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
          }
          weatherTable.snp.makeConstraints {
               $0.top.equalTo(localWeather.snp.bottom).offset(10)
               $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(10)
               $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-10)
               $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
          }
     }
}
/*
extension UIImage {
     
     func getImg(weather: WeatherDataSource, day: Int) -> UIImage {
          DispatchQueue.global().async {
               guard let imgURL = URL(string: weather.url + "/static/img/weather/png/\(weather.info[day].abbr).png") else {
                    return Error
               }
               
               guard let data = try Data(contentsOf: imgURL) else {
                    return
               }
               
               return UIImage(data: data)
          }
     }
     
}
*/
