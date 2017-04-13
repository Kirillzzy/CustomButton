//
//  CustomButton.swift
//  CustomButton
//
//  Created by Kirill Averyanov on 13/04/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    return self.loadFromNibIfEmbeddedInDifferentNib()
  }
  
  @IBOutlet var mainLabel: UILabel!
}
