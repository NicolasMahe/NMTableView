//
//  NMTableViewCellData.swift
//  NMTableView
//
//  Created by Nicolas Mahé on 30/05/16.
//  Copyright © 2016 Nicolas Mahé. All rights reserved.
//

import UIKit

/**
 The cell data structure
 */
open class NMTableViewCellData {
  var cellClass: NMTableViewCell.Type
  var numberOfRows: (_ inSection: Int) -> Int
  var config: (_ cell: NMTableViewCell, _ indexPath: IndexPath) -> Void
  var didSelect: (_ cell: NMTableViewCell, _ tableView: UITableView, _ indexPath: IndexPath) -> Void
  var headerClass: NMTableViewHeaderViewController.Type?
  var headerConfig: (_ controller: NMTableViewHeaderViewController, _ section: Int) -> Void
  
  /**
   Classic init
   */
  public init<T: NMTableViewCell, V: NMTableViewHeaderViewController>(
    cellClass: T.Type,
    numberOfRows: ((_ inSection: Int) -> Int)? = nil,
    config: ((_ cell: T, _ indexPath: IndexPath) -> Void)? = nil,
    didSelect: ((_ cell: T, _ tableView: UITableView, _ indexPath: IndexPath) -> Void)? = nil,
    headerClass: V.Type? = nil,
    headerConfig: ((_ controller: V, _ section: Int) -> Void)? = nil
  ) {
    self.cellClass = cellClass
    
    if let numberOfRows = numberOfRows {
      self.numberOfRows = numberOfRows
    }
    else {
      self.numberOfRows = { (_) -> Int in return 1 }
    }
    
    self.config = { (cell: NMTableViewCell, indexPath: IndexPath) -> Void in
      let cell = cell as! T
      config?(cell, indexPath)
    }
    
    self.didSelect = { (cell: NMTableViewCell, tableView: UITableView, indexPath: IndexPath) -> Void in
      let cell = cell as! T
      didSelect?(cell, tableView, indexPath)
    }
    
    self.headerClass = headerClass
    self.headerConfig = { (controller: NMTableViewHeaderViewController, section: Int) in
      let controller = controller as! V
      headerConfig?(controller, section)
    }
  }
  
  
}
