//
//  NewsViewController.swift
//  Runner
//
//  Created by MAC on 28/12/2020.
//

import Foundation
import UIKit

class NewsViewController: UIViewController {
    var coordinatorDelegate: NewsCoordinatorDelegate?
    override func viewDidLoad() {
       super.viewDidLoad()
    }
    @IBAction func goToFlutter(_ sender: Any){
      coordinatorDelegate?.navigateToFlutter()
    }
  }
