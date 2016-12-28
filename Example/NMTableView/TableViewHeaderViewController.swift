//
//  TableViewHeaderViewController.swift
//  NMTableView
//
//  Created by Nicolas Mahé on 05/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import NMTableView

class TableViewHeaderViewController: NMTableViewHeaderViewController {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  override class var height: CGFloat { return 40 }
  
  @IBOutlet weak var label: UILabel!
  
  var textLabel: String?
  
  //----------------------------------------------------------------------------
  // MARK: - Life cycle
  //----------------------------------------------------------------------------
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.label.text = self.textLabel
  }
}
