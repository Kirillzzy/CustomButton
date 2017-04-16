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

  @IBOutlet var label: UILabel!
  @IBOutlet var view: UIView!
  @IBOutlet var viewHeight: NSLayoutConstraint!

  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    return self.loadFromNibIfEmbeddedInDifferentNib()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    setUp()
  }

  weak var delegate: CustomButtonDelegate?

  private func setUp() {
    layer.masksToBounds = true
    layer.cornerRadius = 10
    view.backgroundColor? = .clear
    backgroundColor = .red
    viewHeight.constant = frame.height
    view.isHidden = true
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
    delegate?.buttonIn()
    backgroundColor = nessesaryBackgroundColor?.tapButtonChangeColor
  }

  private func buttonTouchedOut() {
    delegate?.buttonOut()
    backgroundColor = nessesaryBackgroundColor
  }

  override var isHighlighted: Bool {
    didSet {
      if oldValue != isHighlighted {
        notChange = true
        updateAppearance()
      }
    }
  }

  override var isEnabled: Bool {
    didSet {
      if oldValue != isEnabled {
        notChange = true
        updateAppearance()
      }
    }
  }

  override var isSelected: Bool {
    didSet {
      if oldValue != isSelected {
        notChange = true
        updateAppearance()
      }
    }
  }

}
