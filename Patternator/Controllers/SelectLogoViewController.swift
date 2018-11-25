//
//  SelectLogoViewController.swift
//  AppleBackground
//
//  Created by PilGwonKim on 11/11/2018.
//  Copyright © 2018 pilgwon. All rights reserved.
//

import UIKit

protocol SelectLogoViewControllerDelegate: AnyObject {
    func logoSelected(imageTitle: String)
}

class SelectLogoViewController: BaseViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    @IBOutlet var logoCollectionView: UICollectionView!
    
    weak var delegate: SelectLogoViewControllerDelegate?
    
    var logoList: Array<String> = []
    
    let logoCount: Int = 371
    let itemsPerRow: CGFloat = 4
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 100.0, right: 10.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadLogos()
        self.logoCollectionView.reloadData()
    }
    
    func loadLogos() {
        logoList = []
        for i in 1...logoCount {
            logoList.append("AppleLogo\(i)")
        }
    }

    // MARK: Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return logoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogoCollectionViewCell", for: indexPath) as! LogoCollectionViewCell
        cell.initCell(imageTitle: logoList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.logoSelected(imageTitle: logoList[indexPath.row])
    }
    
}


