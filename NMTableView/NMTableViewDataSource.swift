//
//  NMTableViewController.swift
//  NMTableView
//
//  Created by Nicolas Mahé on 27/05/16.
//  Copyright © 2016 Nicolas Mahé. All rights reserved.
//

import UIKit

//@todo: use same NMTableViewCellData for multiple section
// - add multiple time the same NMTableViewCellData?
// - add with an array of index?

open class NMTableViewDataSource: NSObject, UITableViewDataSource {
  
  //----------------------------------------------------------------------------
  // MARK: - Properties
  //----------------------------------------------------------------------------
  
  /**
   Array of all cell init from these table view controller
   */
  public var tableViewCells = [NMTableViewCell?]()
  
  /**
   The array of NMTableViewCellData
   */
  var cellsData: [NMTableViewCellData]
  
  /**
   Table View Controller
   */
  weak var tableViewController: NMTableViewController?

  //----------------------------------------------------------------------------
  // MARK: - Init
  //----------------------------------------------------------------------------
  
  /**
   Add a NMTableViewCellData to the controller
   */
  public init(
    tableViewController: NMTableViewController,
    data: [NMTableViewCellData]
  ) {
    self.cellsData = data
    
    super.init()
    
    self.tableViewController = tableViewController
    data.forEach {
      tableViewController.registerCell($0.cellClass)
    }
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Table View Delegate for Data
  //----------------------------------------------------------------------------
  
  public func numberOfSections(in tableView: UITableView) -> Int {
    //wait for tableView to load completely
    guard self.tableViewController?.shouldShowLoader == 0
      else {
        return 0
    }
    
    return self.cellsData.count
  }
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.cellsData[section].numberOfRows(section)
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cellData = self.cellsData[indexPath.section]
    
    let cell = tableView.dequeueReusableCell(
      withIdentifier: cellData.cellClass.identifier,
      for: indexPath
    ) as! NMTableViewCell
    
    cell.tableViewController = self.tableViewController
    cell.indexPath = indexPath
    
    let appendCellToCells = { [weak cell] () -> Void in
      self.tableViewCells.append(cell)
    }
    appendCellToCells()
    
    cellData.config(cell, indexPath)
    
    return cell
  }
  
}
