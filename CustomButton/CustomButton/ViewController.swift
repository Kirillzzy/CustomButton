//
//  ViewController.swift
//  CustomButton
//
//  Created by Kirill Averyanov on 13/04/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var customButton: CustomButton! {
    didSet {
      customButton.backgroundColor = .red
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    customButton.delegate = self
  }

  @IBAction func buttonPressed(_ sender: Any) {
    print("Test")
  }
}

extension ViewController: CustomButtonDelegate {
  func buttonIn() {
    print("In")
  }

  func buttonOut() {
    print("Out")
  }
}
