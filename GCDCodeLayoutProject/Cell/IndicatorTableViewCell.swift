//
//  IndicatorTableViewCell.swift
//  GCDCodeLayoutProject
//
//  Created by 윤형찬 on 2021/04/29.
//

import UIKit
import SnapKit

class IndicatorTableViewCell: UITableViewCell {
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
     
     lazy var regionLabel: UILabel = {
          let lbl = UILabel(frame: .zero)
          drawLabel(lbl: lbl, size: 20, text: "Region", v: regionView)
          return lbl
     } ()

     lazy var todayLabel: UILabel = {
          let lbl = UILabel(frame: .zero)
          drawLabel(lbl: lbl, size: 20, text: "Today", v: todayView)
          return lbl
     } ()

     lazy var tomorowLabel: UILabel = {
          let lbl = UILabel(frame: .zero)
          drawLabel(lbl: lbl, size: 20, text: "Tomorrow", v: tomorrowView)
          return lbl
     } ()
          
     override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
          setupConstraint()
     }
     
}

extension IndicatorTableViewCell {
     
     func setupConstraint() {
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
          
          regionLabel.snp.makeConstraints { make in
               make.centerX.centerY.equalToSuperview()
               make.size.equalToSuperview()
          }

          todayLabel.snp.makeConstraints { make in
               make.center.equalToSuperview()
               make.width.height.equalToSuperview()
          }

          tomorowLabel.snp.makeConstraints { make in
               make.center.equalToSuperview()
               make.size.equalToSuperview()
          }
     }
}




