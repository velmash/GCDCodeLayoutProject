//
//  CellFunctions.swift
//  GCDCodeLayoutProject
//
//  Created by 윤형찬 on 2021/04/29.
//

import Foundation
import UIKit

extension UITableViewCell {
     func drawView(v: UIView) {
          v.layer.borderColor = UIColor.gray.cgColor
          v.layer.borderWidth = 1
          self.addSubview(v)
     }
     
     func drawLabel(lbl: UILabel, size: CGFloat, text: String, v: UIView) {
          lbl.textAlignment = .center
          lbl.font = UIFont.systemFont(ofSize: size, weight: .bold)
          lbl.lineBreakMode = .byCharWrapping
          lbl.text = text
          v.addSubview(lbl)
     }
}
