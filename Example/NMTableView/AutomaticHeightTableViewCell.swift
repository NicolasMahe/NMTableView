//
//  AutomaticHeightTableViewCell.swift
//  NMTableView
//
//  Created by Nicolas Mahé on 05/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import NMTableView

class AutomaticHeightTableViewCell: NMTableViewCell {

  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  override class var identifier: String { return "AutomaticHeightTableViewCell" }
  override class var height: CGFloat { return UITableViewAutomaticDimension }
  
  @IBOutlet weak var label: UILabel!
  
  //----------------------------------------------------------------------------
  // MARK: - UI
  //----------------------------------------------------------------------------
  
  func set(text: String) {
    self.label.text = text
  }
  
}
