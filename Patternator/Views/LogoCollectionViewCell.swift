//
//  LogoCollectionViewCell.swift
//  AppleBackground
//
//  Created by PilGwonKim on 12/11/2018.
//  Copyright © 2018 pilgwon. All rights reserved.
//

import UIKit

class LogoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    func initCell(imageTitle: String) {
        imageView.image = UIImage.init(named: imageTitle)
    }
    
    
}
