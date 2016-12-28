//
//  AnimationExtension.swift
//  NMBaseUIClasses
//
//  Created by Nicolas Mahé on 31/05/16.
//  Copyright © 2016 Nicolas Mahé. All rights reserved.
//

import UIKit

//@todo: add example

extension UIView {

  /**
   Animate the view
   */
  public class func animate(
    view: UIView? = nil,
         animated: Bool = true,
         duration: Double = 0.3,
         option: UIViewAnimationOptions = .curveEaseOut,
         constant: (() -> Void)? = nil,
         modification: (() -> Void)? = nil,
         completion: (() -> Void)? = nil
  ) {
    
    if animated {
      
      DispatchQueue.main.async {
        view?.layoutIfNeeded()
        constant?()

        UIView.animate(
          withDuration: duration,
          delay: 0.0,
          options: option,
          animations: { () -> Void in ()
            view?.layoutIfNeeded()
            modification?()
          },
          completion: { (success:Bool) -> Void in ()
            completion?()
          }
        )
      }
      
    }
    else {
      view?.layoutIfNeeded()
      constant?()
      modification?()
      completion?()
    }
  }
  
  /**
   Perform a transition animation
   */
  public class func transition(
    view: UIView,
    active: Bool,
    animated: Bool = true,
    duration: Double = 0.3,
    option: UIViewAnimationOptions = .transitionCrossDissolve,
    animation: @escaping (_ active: Bool) -> Void
  ) {
    
    DispatchQueue.main.async {
      
      UIView.transition(
        with: view,
        duration: animated ? duration : 0.0,
        options: option,
        animations: {
          animation(!active)
        },
        completion: { _ in
          animation(active)
        }
      )
      
    }
    
  }

}
