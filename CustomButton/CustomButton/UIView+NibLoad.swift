//
//  UIView+NibLoad.swift
//  CustomButton
//
//  Created by Kirill Averyanov on 21/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

internal extension UIView {
  class func viewFromNib(withOwner owner: Any? = nil) -> Self {
    print(String(describing: type(of: self)))
    let name = String(describing: type(of: self)).components(separatedBy: ".")[0]
    let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: owner, options: nil)[0]
    return cast(view)!
  }

  func loadFromNibIfEmbeddedInDifferentNib() -> Self {
    let isJustAPlaceholder = subviews.count == 0
    if isJustAPlaceholder {
      let theRealThing = type(of: self).viewFromNib()
      theRealThing.frame = frame
      translatesAutoresizingMaskIntoConstraints = false
      theRealThing.translatesAutoresizingMaskIntoConstraints = false
      return theRealThing
    }
    return self
  }
}

private func cast<T, U>(_ value: T) -> U? {
  return value as? U
}
