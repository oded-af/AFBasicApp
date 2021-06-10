//
//  ViewController.swift
//  AFBasicApp
//
//  Created by Oded Rinsky on 10/06/2021.
//

import UIKit
import AppTrackingTransparency

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            if #available(iOS 14, *) {
              ATTrackingManager.requestTrackingAuthorization { (status) in }
            }
    }


}

