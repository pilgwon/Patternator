//
//  BaseViewController.swift
//  AppleBackground
//
//  Created by PilGwonKim on 11/11/2018.
//  Copyright © 2018 pilgwon. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // set navigation title
        self.title = "PATTERNATR"
        
        // hide naviagtion back button title
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
