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

  @IBOutlet fileprivate var label: UILabel!
  @IBOutlet fileprivate var view: UIView!
  @IBOutlet fileprivate var viewHeight: NSLayoutConstraint!
  @IBOutlet fileprivate var leadingCloudImage: NSLayoutConstraint!

  fileprivate var textForLabel = "" {
    didSet {
      label.text = textForLabel
    }
  }

  private let text = "Tap me"
  fileprivate var timer: Timer!

  // MARK: - For loading from Nib
  override func awakeAfter(using aDecoder: NSCoder) -> Any? {
    return self.loadFromNibIfEmbeddedInDifferentNib()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    viewHeight.constant = frame.size.height
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
    backgroundColor = UIColor.purple
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
    textForLabel = ".."
    startTimer()
    UIView.animate(withDuration: 0.3, animations: {
      self.viewHeight.constant += 40.0
      self.layoutIfNeeded()
    })
    leadingCloudImage.constant = -200
    layoutIfNeeded()
    animateClouds()
  }

  private func buttonTouchedOut() {
    delegate?.buttonOut()
    backgroundColor = nessesaryBackgroundColor
    invalidateTimer()
    label.text = text
    UIView.commitAnimations()
    UIView.animate(withDuration: 0.3, animations: {
      self.updateFrame()
      self.layoutIfNeeded()
    })
  }

  private func updateFrame() {
    viewHeight.constant = label.frame.size.height + 30.0
    layoutIfNeeded()
  }

  private func animateClouds() {
    UIView.animate(withDuration: 0.5, animations: {
      self.leadingCloudImage.constant = self.frame.width + 50
      self.layoutIfNeeded()
    }, completion: { _ in
      self.leadingCloudImage.constant = -200.0
    })
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

  // MARK: - For understanding touch coordinates
  /*
  override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.beginTracking(touch, with: event)
    print("BeginTracking")
    return true
  }

  override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
    super.continueTracking(touch, with: event)
    print("ContinueTracking")
    return true
  }

  override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
    super.endTracking(touch, with: event)
    print("EndTracking")
  }

  override func cancelTracking(with event: UIEvent?) {
    super.cancelTracking(with: event)
    print("CancelTracking")
  }
 */

}

// MARK: - For timer animation
extension CustomButton {
  func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 0.05, target: self,
                                 selector: #selector(timerAction), userInfo: nil, repeats: true)
  }

  func timerAction() {
    textForLabel += "."
  }

  func invalidateTimer() {
    if let timer = timer {
      timer.invalidate()
    }
  }
}
