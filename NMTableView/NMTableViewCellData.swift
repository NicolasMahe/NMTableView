//
//  NMTableViewCellData.swift
//  NMTableView
//
//  Created by Nicolas Mahé on 30/05/16.
//  Copyright © 2016 Nicolas Mahé. All rights reserved.
//

import UIKit
import PromiseKit

/**
 The cell data structure
 */
open class NMTableViewCellData {
  public var cellClass: NMTableViewCell.Type
  public var numberOfRows: (_ inSection: Int) -> Int
  public var config: (_ cell: NMTableViewCell, _ indexPath: IndexPath) -> Void
  public var didSelect: (_ cell: NMTableViewCell, _ tableView: UITableView, _ indexPath: IndexPath) -> Void
  public var headerClass: NMTableViewHeaderViewController.Type?
  public var headerConfig: (_ controller: NMTableViewHeaderViewController, _ section: Int) -> Void
  
  /**
   Classic init
   */
  public init<T: NMTableViewCell, V: NMTableViewHeaderViewController>(
    cellClass: T.Type,
    numberOfRows: @escaping ((_ inSection: Int) -> Int) = { (_) -> Int in return 1 },
    config: ((_ cell: T, _ indexPath: IndexPath) -> Void)? = nil,
    didSelect: ((_ cell: T, _ tableView: UITableView, _ indexPath: IndexPath) -> Void)? = nil,
    headerClass: V.Type? = nil,
    headerConfig: ((_ controller: V, _ section: Int) -> Void)? = nil
  ) {
    self.cellClass = cellClass
    self.numberOfRows = numberOfRows
    
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
  
  /**
   This function force the data to be refreshed.
   Nothing to do is this class
   */
  open func reloadData() -> Promise<Void> {
    return Promise(value: ())
  }
  
  
}
