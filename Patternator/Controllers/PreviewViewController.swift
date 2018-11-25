//
//  PreviewViewController.swift
//  AppleBackground
//
//  Created by PilGwonKim on 11/11/2018.
//  Copyright © 2018 pilgwon. All rights reserved.
//

import UIKit
import FloatingPanel

class PreviewViewController: BaseViewController, FloatingPanelControllerDelegate, SelectLogoViewControllerDelegate {
    
    enum BGType: Int {
        case january = 101, flexin, howdoilook
    }
    
    @IBOutlet var previewView: UIView!
    
    var fpc: FloatingPanelController!
    var iconImage: String = "AppleLogo1"
    var backgroundType: Int = 0
    var iconImageViews: Array<UIImageView> = []
    var backgroundColor: UIColor = UIColor.white
    
    let singleIconSize: CGFloat = 200
    
    let multiIconSize: CGFloat = 80
    let multiIconPerLine: Int = 5
    var multiIconPadding: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initComponents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Remove the views managed by the `FloatingPanelController` object from self.view.
        fpc.removePanelFromParent(animated: false)
    }
    
    
    // MARK: Init Components

    func initComponents() {
        self.initSaveButton()
        self.initFloatingPanel()
        self.initIcons()
        self.changeImage()
        self.backgroundColorChanged()
        
        // init change background button
        
        // TODO: 프리뷰 화면에서 위로 스와이프하면 패널 show
    }
    
    func initSaveButton() {
        let saveBarButton = UIBarButtonItem.init(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveBarButtonTouched))
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    func initFloatingPanel() {
        fpc = FloatingPanelController()
        fpc.delegate = self
        
        let panelVC = storyboard?.instantiateViewController(withIdentifier: "SBIdSelectLogo") as! SelectLogoViewController
        panelVC.delegate = self
        
        fpc.show(panelVC, sender: nil)
        fpc.track(scrollView: panelVC.logoCollectionView)
        fpc.addPanel(toParent: self)
    }
    
    func initIcons() {
        
        multiIconPadding = (view.frame.width - multiIconSize * CGFloat(multiIconPerLine - 1)) / CGFloat(multiIconPerLine - 1)
        
        switch backgroundType {
            
            case BGType.january.rawValue:
                self.drawIconsJanuary()
            
            case BGType.flexin.rawValue:
                self.drawIconsFlexin()
            
            case BGType.howdoilook.rawValue:
                self.drawIconsHowdoilook()
            
            default:
                break
        }
    }
    
    
    // MARK: Draw Icons
    
    func drawIconsJanuary() {
        iconImageViews = []
        previewView.subviews.forEach({ $0.removeFromSuperview() })

        let navHeight = navigationController!.navigationBar.frame.size.height + UIApplication.shared.statusBarFrame.height
        let centerX = (UIScreen.main.bounds.size.width - singleIconSize) / 2
        let centerY = (UIScreen.main.bounds.size.height - singleIconSize) / 2 - navHeight
        
        let imageView = UIImageView(frame: CGRect(x: centerX, y: centerY, width: singleIconSize, height: singleIconSize))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        previewView.addSubview(imageView)
        iconImageViews.append(imageView)
        
    }
    
    func drawIconsFlexin() {
        iconImageViews = []
        previewView.subviews.forEach({ $0.removeFromSuperview() })
        
        var x: CGFloat = 0.0
        var y: CGFloat = -(multiIconSize / 2)
        
        while (y < previewView.frame.height) {
            x = -(multiIconSize / 2)
            for _ in 0..<multiIconPerLine {
                let imageView = UIImageView(frame: CGRect(x: x, y: y, width: multiIconSize, height: multiIconSize))
                imageView.contentMode = .scaleAspectFit
                imageView.clipsToBounds = true
                previewView.addSubview(imageView)
                iconImageViews.append(imageView)
                
                x += multiIconSize + multiIconPadding
            }
            y += multiIconSize + multiIconPadding
        }
        
    }
    
    func drawIconsHowdoilook() {
        iconImageViews = []
        previewView.subviews.forEach({ $0.removeFromSuperview() })
        
        var x: CGFloat = 0.0
        var y: CGFloat = -(multiIconSize / 2)
        
        var xIndex: Int = 0
        var yIndex: Int = 0
        
        while (y < previewView.frame.height) {
            
            xIndex = 0
            x = -(multiIconSize / 2)
            
            for _ in 0..<multiIconPerLine {
                if (xIndex % 2 == 0 && yIndex % 2 == 1) ||
                    (xIndex % 2 == 1 && yIndex % 2 == 0) {
                    let imageView = UIImageView(frame: CGRect(x: x, y: y, width: multiIconSize, height: multiIconSize))
                    imageView.contentMode = .scaleAspectFit
                    imageView.clipsToBounds = true
                    previewView.addSubview(imageView)
                    iconImageViews.append(imageView)
                }
                
                xIndex += 1
                x += multiIconSize + multiIconPadding
            }
            
            yIndex += 1
            y += multiIconSize / 2 + multiIconPadding
        }
        
    }
    
    
    // MARK: Select Logo View Controller Delegate
    
    func logoSelected(imageTitle: String) {
        fpc.move(to: .tip, animated: true)
        iconImage = imageTitle
        self.changeImage()
    }
    
    
    // MARK: Preview View > Icon Image Views
    
    func changeImage() {
        for imageView in iconImageViews {
            imageView.image = UIImage.init(named: iconImage)
        }
    }
    
    
    // MARK: Save Bar Button
    
    @objc func saveBarButtonTouched() {
        let bgImage = previewView.asImage()
        let imageToShare = [ bgImage ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.postToFacebook ]
        present(activityViewController, animated: true, completion: nil)
    }
    
    
    // Color Picker
    
    @IBAction func changeBackgroundColorButtonTouched() {
        self.showBackgroundColorPickerVC()
    }
    
    func showBackgroundColorPickerVC() {
        let alert = UIAlertController(style: UIAlertController.Style.actionSheet)
        alert.addColorPicker(color: backgroundColor) { color in
            self.backgroundColor = color
            self.backgroundColorChanged()
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
    }
    
    func backgroundColorChanged() {
        previewView.backgroundColor = backgroundColor
    }
    
}
