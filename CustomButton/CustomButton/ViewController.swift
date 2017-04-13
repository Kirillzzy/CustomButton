//
//  ViewController.swift
//  CustomButton
//
//  Created by Kirill Averyanov on 13/04/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var customButton: CustomButton!
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func buttonPressed(_ sender: Any) {
    print("Test")
  }
}

