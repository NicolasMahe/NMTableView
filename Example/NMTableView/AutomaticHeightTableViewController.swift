//
//  AutomaticHeightTableViewController.swift
//  NMTableView
//
//  Created by Nicolas Mahé on 05/12/2016.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import UIKit
import NMTableView

class AutomaticHeightTableViewController: NMTableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //For automatic row height
    self.tableView.rowHeight = UITableViewAutomaticDimension
    self.tableView.estimatedRowHeight = 140
    
    let cellData1 = NMTableViewCellData(
      cellClass: AutomaticHeightTableViewCell.self,
      numberOfRows: { (section: Int) -> Int in
        return 3
      },
      config: { (cell: AutomaticHeightTableViewCell, indexPath: IndexPath) in
        var text: String
        switch indexPath.row {
        case 0:
          text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam nisl leo, tempor sed sagittis et, dapibus eget orci. Nulla id luctus massa. Phasellus sed risus neque. Sed pulvinar, urna nec mattis vulputate, libero ipsum mollis tellus, a elementum orci nunc a nisl. Donec cursus mattis faucibus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed a consectetur neque, ut dapibus elit. Fusce sit amet justo nec augue imperdiet aliquet. Mauris tincidunt lacus eu mattis sagittis. Suspendisse pellentesque tortor ut odio tincidunt, id maximus est semper. Nunc tristique sed ligula ac pulvinar. Vestibulum vitae metus aliquet, sollicitudin quam eu, semper lectus. Duis sed mi diam. Nulla sollicitudin urna ac metus efficitur interdum."
        case 1:
          text = "Sed sed arcu neque. Proin ante enim, consequat sit amet dolor quis, porttitor gravida quam. In hac habitasse platea dictumst. Maecenas vitae dui ultricies, malesuada quam eget, sollicitudin sapien. In in hendrerit orci. Phasellus quis interdum tortor, quis accumsan urna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla erat sem, vestibulum sit amet laoreet et, tristique pulvinar mauris."
        default:
          text = "Phasellus eleifend mauris eu consectetur rhoncus. Curabitur et ultrices velit, sollicitudin eleifend justo. In hac habitasse platea dictumst. Phasellus condimentum nunc sollicitudin lorem laoreet, id sodales augue bibendum. Fusce scelerisque felis nec eros venenatis dignissim quis ut dolor. Proin ultricies, magna quis pretium egestas, nibh nulla egestas ipsum, at vulputate velit est ut augue. Donec eget felis et lacus varius tincidunt placerat in quam. Suspendisse convallis urna ac velit sollicitudin, sit amet rutrum massa dapibus. Integer aliquet magna purus, congue dapibus odio fringilla non. Donec vehicula maximus massa non dignissim."
        }
        cell.set(
          text: text
        )
      }
    )
    
    self.dataSource = NMTableViewDataSource(
      tableViewController: self,
      data: [
        cellData1
      ]
    )
    
  }
  
}
