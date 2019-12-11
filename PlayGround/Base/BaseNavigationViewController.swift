//
//  MainNavigationViewController.swift
//  PlayGround
//
//  Created by kim jason on 24/10/2019.
//  Copyright © 2019 Playground. All rights reserved.
//


import UIKit
import Material
import Localize_Swift
import Motion

class BaseNavigationController: NavigationController {

    var isOverLap:Bool = false

    open override func prepare() {
        super.prepare()

//        if(isOverLap) {
//            isMotionEnabled = true
//            motionTransitionType = .autoReverse(presenting: .cover(direction: .right))
//        }

        guard let v = navigationBar as? NavigationBar else {
            return
        }
        
        v.depthPreset = .none
        v.heightPreset = .default
        v.dividerColor = UIColor.clear
//        v.heightPreset = .xxlarge
        v.backgroundColor = BBWhiteColor
        v.tintColor = BBYellowColor
        v.isTranslucent = true
        v.shadowImage = nil
        v.setBackgroundImage(nil, for: .default)

          if #available(iOS 13.0, *) {
        self.modalPresentationStyle = .fullScreen
        }
        let image: UIImage = UIImage(named: "logo1")!
               let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
               imageView.contentMode = .scaleAspectFit
               imageView.image = image
               self.navigationItem.titleView = imageView
           
        self.navigationItem.backBarButtonItem?.tintColor = BBYellowColor
    }
    
}



