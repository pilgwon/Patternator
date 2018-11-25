//
//  Extensions.swift
//  AppleBackground
//
//  Created by PilGwonKim on 13/11/2018.
//  Copyright © 2018 pilgwon. All rights reserved.
//

import UIKit

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

