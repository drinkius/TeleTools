//
//  ViewController.swift
//  TeleTools
//
//  Created by telegin.alexander@gmail.com on 01/28/2019.
//  Copyright (c) 2019 telegin.alexander@gmail.com. All rights reserved.
//

import UIKit
import TeleTools

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    UILabel().add(to: view).do {
      $0.text = "This is a label"
      $0.textAlignment = .center
      $0.edgesToSuperview()
    }
  }
}
