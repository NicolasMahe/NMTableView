//
//  RectExtension.swift
//  NMBaseUIClasses
//
//  Created by Nicolas Mahé on 15/06/15.
//  Copyright (c) 2015 Nicolas Mahé. All rights reserved.
//

import CoreGraphics

extension CGRect {
  
  /**
  Init with an origin of Zero and the specified size
  */
  public init(size: CGSize) {
    self.init(
      origin: CGPoint.zero,
      size: size
    )
  }
  
  /**
  Set the origin of the CGRect to zero
  */
  public func removeOrigin() -> CGRect {
    return CGRect(size: self.size)
  }
  
  /**
  Modify on the fly a CGRect
  */
  public func set(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) -> CGRect {
    return CGRect(
      x: x ?? self.origin.x,
      y: y ?? self.origin.y,
      width: width ?? self.size.width,
      height: height ?? self.size.height
    )
  }
  
  /**
   Add value on the fly to a CGRect
   */
  public func add(x: CGFloat? = nil, y: CGFloat? = nil, width: CGFloat? = nil, height: CGFloat? = nil) -> CGRect {
    return CGRect(
      x: self.origin.x + (x ?? 0),
      y: self.origin.y + (y ?? 0),
      width: self.size.width + (width ?? 0),
      height: self.size.height + (height ?? 0)
    )
  }
  
  /**
  Set new width and height and re-calculate the origin for centered alignment
  */
  public func setCentered(size: CGSize) -> CGRect {
    let sizeActual = self.size
    let originActual = self.origin
    
    let diffWidth = sizeActual.width - size.width
    let diffHeight = sizeActual.height - size.height
    
    let newOrigin = CGPoint(
      x: originActual.x + diffWidth / 2,
      y: originActual.y + diffHeight / 2
    )
    
    return CGRect(
      origin: newOrigin,
      size: size
    )
  }
  
}

extension CGSize {
  
  /**
   Init with the same size for both width and height
   */
  init(size: CGFloat) {
    self.init(
      width: size,
      height: size
    )
  }
  
  /**
   Modify on the fly a CGSize
   */
  func set(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
    return CGSize(
      width: width ?? self.width,
      height: height ?? self.height
    )
  }
  
  /**
   Add value on the fly to a CGSize
   */
  func add(width: CGFloat? = nil, height: CGFloat? = nil) -> CGSize {
    return CGSize(
      width: self.width + (width ?? 0.0),
      height: self.height + (height ?? 0.0)
    )
  }
  
}

