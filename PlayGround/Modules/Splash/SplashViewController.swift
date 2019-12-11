//
//  SplashViewController.swift
//  PlayGround
//
//  Created by kim jason on 22/10/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import SnapKit
import Material
import RevealingSplashView

class SplashViewController:BaseViewController{
    
    var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareViews()
        self.showMainView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
 
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


extension SplashViewController {
    
    
    func prepareViews() {
        self.imageView = UIImageView(image: UIImage(named:"SplashView"))
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints{ m in
            m.width.height.equalTo(127)
            m.centerX.centerY.equalToSuperview()
        }
        
    }
    
    func showMainView() {
        //Initialize a revealing Splash with with the iconImage, the initial size and the background color
//         let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "SplashView")!,iconInitialSize: CGSize(width: 127, height: 127), backgroundColor: BBWhiteColor)
//        revealingSplashView.animationType = SplashAnimationType.
//         //Adds the revealing splash view as a sub view
//         self.view.addSubview(revealingSplashView)
//
//         //Starts animation
//         revealingSplashView.startAnimation(){
//            self.presentMainViewController()
//         }
        
        
        UIView.animate(withDuration: 1.5, animations: {
            self.imageView.alpha = 0.0
        }, completion: { (completed) in
            self.presentMainViewController()
        })
//
//        let time : DispatchTime = DispatchTime.now() + Double(3)
//        DispatchQueue.main.asyncAfter(deadline: time) {
//            self.presentMainViewController()
//        }
    }
}
