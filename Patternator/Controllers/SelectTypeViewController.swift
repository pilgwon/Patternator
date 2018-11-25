//
//  SelectTypeViewController.swift
//  AppleBackground
//
//  Created by PilGwonKim on 11/11/2018.
//  Copyright © 2018 pilgwon. All rights reserved.
//

import UIKit

class SelectTypeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initComponents()
    }
    
    func initComponents() {
        
        // TODO: 앱 켤 때마다 로고 랜덤으로 바뀌게 (타입별로 다르게, 타입내에선 모두 똑같은 로고)
    }
    
    @IBAction func typeButtonTouched(sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SBIdPreview") as! PreviewViewController
        vc.backgroundType = sender.tag
        navigationController?.pushViewController(vc, animated: true)
    }

}
