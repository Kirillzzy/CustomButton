//
//  CustomButton.swift
//  CustomButton
//
//  Created by Kirill Averyanov on 13/04/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

  private var nessesaryBackgroundColor: UIColor?
  private var isSetup = false
  private var notChange = false

  @IBOutlet var mainLabel: UILabel!

  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    return self.loadFromNibIfEmbeddedInDifferentNib()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()

  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    layer.masksToBounds = true
    layer.cornerRadius = 10
  }

  override var backgroundColor: UIColor? {
    didSet {
      if oldValue == backgroundColor || notChange {
        notChange = false
        return
      }

      if !isSetup {
        nessesaryBackgroundColor = backgroundColor
        notChange = true
        backgroundColor = oldValue
      }

      updateAppearance()
    }
  }

  private func updateAppearance() {
    isSetup = true
    if (isSelected || isHighlighted) && isEnabled {
      buttonTouchedIn()
    } else {
      buttonTouchedOut()
    }
    alpha = isEnabled ? 1 : 0.8

    isSetup = false
  }

  private func buttonTouchedIn() {
    backgroundColor = nessesaryBackgroundColor?.tapButtonChangeColor
  }

  private func buttonTouchedOut() {
    backgroundColor = nessesaryBackgroundColor
  }

  override var isHighlighted: Bool {
    didSet {
      if oldValue != isHighlighted {
        updateAppearance()
      }
    }
  }

  override var isEnabled: Bool {
    didSet {
      if oldValue != isEnabled {
        updateAppearance()
      }
    }
  }

  override var isSelected: Bool {
    didSet {
      if oldValue != isSelected {
        updateAppearance()
      }
    }
  }

}
