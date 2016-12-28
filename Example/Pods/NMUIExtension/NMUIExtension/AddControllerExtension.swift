//
//  AddControllerExtension.swift
//  NMBaseUIClasses
//
//  Created by Nicolas Mahé on 28/03/16.
//  Copyright © 2016 Nicolas Mahé. All rights reserved.
//

import UIKit
import SnapKit
import NMCGExtension

extension UIViewController {
  
  /**
   Add a view controller or a table view controller as child controller and set the view's size
   */
  public func add(
    viewController: UIViewController,
    toView view: UIView
    ) {
    view.add(view: viewController.view)
    self.addChildViewController(viewController)
  }
  
  public func addWithConstraint(
    viewController: UIViewController,
    toView view: UIView
    ) {
    view.addWithConstraint(view: viewController.view)
    self.addChildViewController(viewController)
  }
  
  /**
   Add a view controller as child controller and set the view's size to the child size
   */
  public func add(
    viewControllerChildSized viewController: UIViewController,
    toView view: UIView
  ) {
    view.add(viewChildSized: viewController.view)
    self.addChildViewController(viewController)
  }
  
}

extension UIView {
  
  /**
   Add a view controller or a table view controller as child controller and set the view's size
   */
  public func add(
    view: UIView
  ) {
    view.frame = self.frame.removeOrigin()
    self.addSubview(view)
  }
  
  /**
   Add a view controller as child controller and set the view's size to the child size
   */
  public func addWithConstraint(
    view: UIView
  ) {
    self.translatesAutoresizingMaskIntoConstraints = false
    view.translatesAutoresizingMaskIntoConstraints = false
    
    self.updateConstraints()
    view.updateConstraints()
    
    self.addSubview(view)
    self.snp.makeConstraints { (make) in
      make.edges.equalTo(view)
    }
  }
  
  /**
   Add a view controller as child controller and set the view's size to the child size
   */
  public func add(
    viewChildSized: UIView
  ) {
    
    self.translatesAutoresizingMaskIntoConstraints = false
    viewChildSized.translatesAutoresizingMaskIntoConstraints = false
    
    self.updateConstraints()
    viewChildSized.updateConstraints()
    
    //add subview
    self.addSubview(viewChildSized)
    
    //create constraint top and left on view controller
    self.snp.makeConstraints { (make) in
      make.edges.top.equalTo(viewChildSized)
      make.edges.left.equalTo(viewChildSized)
    }
    
    viewChildSized.translatesAutoresizingMaskIntoConstraints = false
    viewChildSized.layoutIfNeeded()
    
    //create constraint width and height on self
    self.snp.makeConstraints { (make) in
      make.edges.width.equalTo(viewChildSized)
      make.edges.height.equalTo(viewChildSized)
    }
  }
  
}
