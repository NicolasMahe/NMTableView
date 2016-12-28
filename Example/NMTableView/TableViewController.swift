//
//  TableViewController.swift
//  NMTableView
//
//  Created by Nicolas Mahé on 05/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import NMTableView

class TableViewController: NMTableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    let cellData1 = NMTableViewCellData(
      cellClass: TableViewCell.self,
      numberOfRows: { (section: Int) -> Int in
        return 2 + section
      },
      config: { (cell: TableViewCell, indexPath: IndexPath) in
        cell.textLabel?.text = "Row " + indexPath.row.description
      },
      didSelect: { (cell: TableViewCell, tableView: UITableView, indexPath: IndexPath) in
        print("Row " + indexPath.section.description + "-" + indexPath.row.description + " selected")
        cell.setSelected(false, animated: true)
      },
      headerClass: TableViewHeaderViewController.self,
      headerConfig: { (controller: TableViewHeaderViewController, section: Int) in
        controller.textLabel = "Section header " + section.description
      }
    )
    
    self.dataSource = NMTableViewDataSource(
      tableViewController: self,
      data: [
        cellData1, cellData1, cellData1
      ]
    )
    
  }

}
