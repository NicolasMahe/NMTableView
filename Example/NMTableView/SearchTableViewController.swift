//
//  SearchTableViewController.swift
//  NMTableView
//
//  Created by Nicolas Mahé on 05/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import NMTableView

class SearchTableViewController: NMTableViewController {
  
  var dataOriginal = [
    "Ward Loeffler",
    "Nyla Lemaster",
    "Jerome Jamieson",
    "Basil Michaelsen",
    "Nicolas Carone",
    "Theressa Carraway",
    "Leonia Keesee",
    "Tameka Laracuente",
    "Evalyn Exley",
    "Oneida Pinette",
    ]
  var data: [String]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Copy data original to data
    self.data = self.dataOriginal
    
    let cellData1 = NMTableViewCellData(
      cellClass: TableViewCell.self,
      numberOfRows: { [weak self] (section: Int) -> Int in
        return self?.data.count ?? 0
      },
      config: { [weak self] (cell: TableViewCell, indexPath: IndexPath) in
        cell.textLabel?.text = self?.data[indexPath.row]
      }
    )
    
    self.dataSource = NMTableViewDataSource(
      tableViewController: self,
      data: [ cellData1 ]
    )
    
    //Init the search functionality
    self.searchFilter = { [weak self] (search: String) in
      guard let this = self else { return }
      guard search.isEmpty == false else {
        self?.data = this.dataOriginal
        return
      }
      self?.data = this.dataOriginal
        .filter { (name: String) -> Bool in
          return name.localizedCaseInsensitiveContains(search)
      }
    }
    
  }
  
}
