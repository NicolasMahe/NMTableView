//
//  UINavigationBarExtension.swift
//  Pods
//
//  Created by Nicolas Mahé on 23/12/2016.
//
//

import UIKit

extension UINavigationBar {
  
  public func setBottomBorderColor(color: UIColor, height: CGFloat) {
    let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
    let bottomBorderView = UIView(frame: bottomBorderRect)
    bottomBorderView.backgroundColor = color
    self.addSubview(bottomBorderView)
  }
  
}
