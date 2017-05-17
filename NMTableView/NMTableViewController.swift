//
//  NMTableViewController.swift
//  NMTableView
//
//  Created by Nicolas Mahé on 30/05/16.
//  Copyright © 2016 Nicolas Mahé. All rights reserved.
//

import UIKit
import NMUIExtension

open class NMTableViewController: UITableViewController, UISearchResultsUpdating {

  //----------------------------------------------------------------------------
  // MARK: - Helper
  //----------------------------------------------------------------------------
  
  open func reloadTableView(blockTableViewReload: Bool = false) {
    if blockTableViewReload == false {
      let indexPathSelected = self.tableView.indexPathForSelectedRow
      self.tableView.reloadData()
      self.tableView.selectRow(at: indexPathSelected, animated: false, scrollPosition: .none)
    }
    self.setEmptyViewState()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Datasource
  //----------------------------------------------------------------------------
  
  /**
   The data source
   */
  open var dataSource: UITableViewDataSource? {
    didSet {
      self.tableView.dataSource = dataSource
    }
  }
  
  var headerControllerCache = [Int: NMTableViewHeaderViewController]()
  
  public var dataSourceTyped: NMTableViewDataSource? {
    return self.tableView.dataSource as? NMTableViewDataSource
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Table view delegate
  //----------------------------------------------------------------------------
  
  override open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let dataSource = self.dataSource as? NMTableViewDataSource,
      let cell = self.tableView.cellForRow(at: indexPath) as? NMTableViewCell
    else { return }
    dataSource.cellsData[indexPath.section].didSelect(
      cell,
      tableView,
      indexPath
    )
  }
  
  override open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard let dataSource = self.dataSource as? NMTableViewDataSource
      else { return 0.0 }
    let data = dataSource.cellsData[indexPath.section]
    return data.cellClass.height
  }
  
  override open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let
      dataSource = self.dataSource as? NMTableViewDataSource,
      let headerClass = dataSource.cellsData[section].headerClass
      else { return 0.0 }
    
    return headerClass.height
  }
  
  override open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let
      dataSource = self.dataSource as? NMTableViewDataSource
      else { return nil }
    
    let cellsData = dataSource.cellsData[section]
    
    guard let headerClass = cellsData.headerClass
      else { return nil }
    
    var controller = self.headerControllerCache[section]
    if controller == nil {
      controller = headerClass.init()
      self.addChildViewController(controller!)
      self.headerControllerCache[section] = controller
    }
    
    cellsData.headerConfig(controller!, section)
    
    return controller?.view
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Helpers
  //----------------------------------------------------------------------------
  
  /**
   Register a NMTableViewCell easy
   */
  func registerCell(_ forClass: NMTableViewCell.Type) {
    self.tableView.register(
      UINib(
        nibName:forClass.identifier,
        bundle: Bundle(for: forClass.self)
      ),
      forCellReuseIdentifier: forClass.identifier
    )
  }
  
  /**
   Propage resignFirstResponder on every cells
   */
  override open func resignFirstResponder() -> Bool {
    if let dataSource = self.dataSource as? NMTableViewDataSource {
      dataSource.tableViewCells.forEach {
        $0?.resignFirstResponder()
      }
    }
    return super.resignFirstResponder()
  }
  
  
  //----------------------------------------------------------------------------
  // MARK: - table Header view height
  //----------------------------------------------------------------------------
  
  override open func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
    // Dynamic sizing for the header view
    if let headerView = tableView.tableHeaderView {
      let height = headerView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
      var headerFrame = headerView.frame
      
      // If we don't have this check, viewDidLayoutSubviews() will get
      // repeatedly, causing the app to hang.
      if height != headerFrame.size.height {
        headerFrame.size.height = height
        headerView.frame = headerFrame
        tableView.tableHeaderView = headerView
      }
    }
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Search
  //----------------------------------------------------------------------------
  
  var searchController: UISearchController?
  public var searchFilter: ((_ search: String) -> Void)? {
    didSet {
      guard self.searchController == nil else { return }
      self.searchController = UISearchController(searchResultsController: nil)
      self.searchController?.searchResultsUpdater = self
      self.searchController?.dimsBackgroundDuringPresentation = false
      self.tableView.tableHeaderView = self.searchController?.searchBar
      self.definesPresentationContext = true
    }
  }
  
  open func updateSearchResults(for searchController: UISearchController) {
    guard let search = searchController.searchBar.text else { return }
    self.searchFilter?(search)
    self.tableView.reloadData()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Empty state
  //----------------------------------------------------------------------------
  
  //@todo: add example
  //@todo: add default controller
  public var emptyControllerShowCondition: (() -> Bool)? {
    didSet {
      self.setEmptyViewState()
    }
  }
  open var emptyController: UIViewController? {
    didSet {
      guard let emptyController = self.emptyController
        else { return }
      self.add(
        viewController: emptyController,
        toView: self.tableView
      )
      self.setEmptyViewState()
    }
  }
  
  open func setEmptyViewState(forceShow: Bool? = nil) {
    guard let emptyController = self.emptyController,
      var conditionShow = self.emptyControllerShowCondition?()
      else { return }
    
    conditionShow = forceShow ?? conditionShow
    
    emptyController.view.isHidden = conditionShow == false
    
    self.setSeparatorStyle()
    
    self.bringSubviewToFront()
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Loader
  //----------------------------------------------------------------------------
  
  //@todo: add example
  //@todo: add default controller
  public var shouldShowLoader: Int = 0 {
    didSet {
      //check if inferior to 0
      if self.shouldShowLoader < 0 {
        self.shouldShowLoader = 0
      }
      
      self.reloadTableView()
      
      self.loaderController?.view.isHidden = self.shouldShowLoader == 0
      self.setEmptyViewState(forceShow: self.shouldShowLoader > 0 ? false : nil)
      self.setSeparatorStyle()
      
      self.bringSubviewToFront()
    }
  }
  open var loaderController: UIViewController? {
    didSet {
      guard let loaderController = self.loaderController
        else { return }
      self.add(
        viewController: loaderController,
        toView: self.tableView //@todo: the view doesn't cover all the table view content when the table view content is longer than the screen
      )
      self.shouldShowLoader = 0
    }
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Helper
  //----------------------------------------------------------------------------
  
  public func bringSubviewToFront() {
    if let emptyController = self.emptyController {
      self.tableView.bringSubview(toFront: emptyController.view)
    }
    if let loaderController = self.loaderController {
      self.tableView.bringSubview(toFront: loaderController.view)
    }
    if let tableHeaderView = self.tableView.tableHeaderView {
      self.tableView.bringSubview(toFront: tableHeaderView)
    }
  }
  
  //----------------------------------------------------------------------------
  // MARK: - Separator style helper
  //----------------------------------------------------------------------------
  
  public var separatorStyleDefault: UITableViewCellSeparatorStyle = .singleLine {
    didSet {
      self.tableView.separatorStyle = self.separatorStyleDefault
    }
  }
  
  func setSeparatorStyle() {
    let conditionShow = self.shouldShowLoader > 0 || self.emptyControllerShowCondition?() == true
    self.tableView.separatorStyle = conditionShow ? .none : self.separatorStyleDefault
  }
  
}
