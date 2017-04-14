//
//  UIColor+Brightness.swift
//  CustomButton
//
//  Created by Kirill Averyanov on 14/04/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

extension UIColor {

  var tapButtonChangeColor: UIColor {
    var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
    if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
      red *= 255.0
      green *= 255.0
      blue *= 255.0
      // Special formula
      let brightness = sqrt(red * red * 0.241 + green * green * 0.691 + blue * blue * 0.068)
      if brightness < 130 {
        return lighterColorForColor()
      }
    }
    return darkerColorForColor()
  }

  private func darkerColorForColor() -> UIColor {
    return changeColor(value: -0.2)
  }

  private func lighterColorForColor() -> UIColor {
    return changeColor(value: 0.2)
  }

  private func changeColor(value: CGFloat) -> UIColor {
    var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
    if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
      return UIColor(red: min(red + value, 1.0),
                     green: min(green + value, 1.0),
                     blue: min(blue + value, 1.0),
                     alpha: alpha)
    }
    return self
  }
}
