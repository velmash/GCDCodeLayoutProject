//
//  MainTableViewCell.swift
//  GCDCodeLayoutProject
//
//  Created by 윤형찬 on 2021/04/29.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
//MARK: - Properties
     lazy var regionView: UIView = {
          let v = UIView(frame: .zero)
          drawView(v: v)
          return v
     } ()
     
     lazy var todayView: UIView = {
          let v = UIView(frame: .zero)
          drawView(v: v)
          return v
     } ()
     
     lazy var tomorrowView: UIView = {
          let v = UIView(frame: .zero)
          drawView(v: v)
          return v
     } ()
     
     lazy var localName: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.font = UIFont.systemFont(ofSize: 14)
          lbl.textAlignment = .center
          lbl.numberOfLines = 0
          lbl.lineBreakMode = .byCharWrapping
          return lbl
     } ()
     
     lazy var todayImage: UIImageView = UIImageView()
     lazy var tomorrowImage: UIImageView = UIImageView()
     
     lazy var todayWeather: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.font = UIFont.systemFont(ofSize: 11)
          return lbl
     } ()
     lazy var tomorrowWeather: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.font = UIFont.systemFont(ofSize: 11)
          return lbl
     } ()
     
     
     lazy var todayCelcius: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.font = UIFont.systemFont(ofSize: 11)
          lbl.textColor = .red
          return lbl
     } ()
     var tomorrowCelcius: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.font = UIFont.systemFont(ofSize: 11)
          lbl.textColor = .red
          return lbl
     } ()
     
     
     lazy var todayHumadity: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.font = UIFont.systemFont(ofSize: 11)
          return lbl
     } ()
     
     lazy var tomorrowHumadity: UILabel = {
          let lbl = UILabel(frame: .zero)
          lbl.font = UIFont.systemFont(ofSize: 11)
          return lbl
     } ()
     
//MARK: - awakeFromNib
     override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
          addViews()
          setupConstraint()
     }
}


// MARK: - MainTableViewCell 요소 Layout
extension MainTableViewCell {
     func addViews() {
          regionView.addSubview(localName)
          
          todayView.addSubview(todayImage)
          todayView.addSubview(todayWeather)
          todayView.addSubview(todayCelcius)
          todayView.addSubview(todayHumadity)

          tomorrowView.addSubview(tomorrowImage)
          tomorrowView.addSubview(tomorrowWeather)
          tomorrowView.addSubview(tomorrowCelcius)
          tomorrowView.addSubview(tomorrowHumadity)
     }

     
     func setupConstraint() {
          let layoutOffset = self.frame.height * 0.1
          
          regionView.snp.makeConstraints { make in
               make.height.equalToSuperview()
               make.width.equalToSuperview().multipliedBy(0.20)
               make.leading.equalToSuperview()
          }
          
          todayView.snp.makeConstraints { make in
               make.height.equalToSuperview()
               make.width.equalToSuperview().multipliedBy(0.40)
               make.leading.equalTo(regionView.snp.trailing)
               //dd = make.width.equalToSuperview().multipliedBy(0.14).constraint
          }
          
          tomorrowView.snp.makeConstraints { make in
               make.height.equalToSuperview()
               make.width.equalToSuperview().multipliedBy(0.40)
               make.leading.equalTo(todayView.snp.trailing)
          }
          
          localName.snp.makeConstraints {
               $0.center.equalToSuperview()
               $0.width.equalToSuperview()
          }
          
          todayImage.snp.makeConstraints {
               //$0.height.equalTo(todayView.snp.height - todayView.safeAreaLayoutGuide.topAnchor)
               $0.top.leading.equalToSuperview().offset(layoutOffset)
               $0.bottom.equalToSuperview().offset(-layoutOffset)
               
               $0.width.equalTo(todayImage.snp.height).multipliedBy(1)
          }
          
          todayWeather.snp.makeConstraints {
               $0.top.equalToSuperview().offset(layoutOffset * 3)
               $0.leading.equalTo(todayImage.snp.trailing).offset(layoutOffset)
               $0.trailing.equalToSuperview().offset(-layoutOffset)
          }
          
          todayCelcius.snp.makeConstraints {
               $0.leading.equalTo(todayImage.snp.trailing).offset(layoutOffset * 1.5)
               $0.bottom.equalToSuperview().offset(-layoutOffset * 3)
          }
          
          todayHumadity.snp.makeConstraints {
               $0.trailing.equalToSuperview().offset(-layoutOffset)
               $0.bottom.equalToSuperview().offset(-layoutOffset * 3)
          }
          
          tomorrowImage.snp.makeConstraints {
               $0.top.leading.equalToSuperview().offset(layoutOffset)
               $0.bottom.equalToSuperview().offset(-layoutOffset)
               
               $0.width.equalTo(todayImage.snp.height).multipliedBy(1)
          }
          
          tomorrowWeather.snp.makeConstraints {
               $0.top.equalToSuperview().offset(layoutOffset * 3)
               $0.leading.equalTo(tomorrowImage.snp.trailing).offset(layoutOffset)
               $0.trailing.equalToSuperview().offset(-layoutOffset)
          }
          
          tomorrowCelcius.snp.makeConstraints {
               $0.leading.equalTo(tomorrowImage.snp.trailing).offset(layoutOffset * 1.5)
               $0.bottom.equalToSuperview().offset(-layoutOffset * 3)
          }
          
          tomorrowHumadity.snp.makeConstraints {
               $0.trailing.equalToSuperview().offset(-layoutOffset)
               $0.bottom.equalToSuperview().offset(-layoutOffset * 3)
          }
     }
}
