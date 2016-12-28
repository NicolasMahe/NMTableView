//
//  NMTableViewCell.swift
//  NMTableView
//
//  Created by Nicolas Mahé on 27/05/16.
//  Copyright © 2016 Nicolas Mahé. All rights reserved.
//

import UIKit

open class NMTableViewCell: UITableViewCell {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  open class var identifier: String { fatalError("need implementation") }
  open class var height: CGFloat { return UITableViewAutomaticDimension }
  
  public weak var tableViewController: NMTableViewController?
  public var indexPath: IndexPath?

}
