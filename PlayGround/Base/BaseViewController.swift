//
//  BaseViewController.swift
//  PlayGround
//
//  Created by kim jason on 22/10/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import MaterialComponents
import UserNotifications
import SnapKit
import Localize_Swift
import Toast_Swift
import SwiftDate
import MessageUI
import RealmSwift
import SwiftEventBus
import GoogleSignIn
import libPhoneNumber_iOS

class BaseViewController:UIViewController {
    
    var progressBackGroundView: UIView!
    var activityIndicator: MDCActivityIndicator!
    var statusBarOverlayView: UIView!
    
    override func viewDidLoad() {
        self.preapreMainView()
        self.initProgress()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
}


// Views
extension BaseViewController {
    
    func preapreMainView() {
        self.view.backgroundColor = BBMainBackgroundColor
    }
    
    public func initProgress () {
        progressBackGroundView = UIView ()
        progressBackGroundView.backgroundColor = BBBlack2Color.withAlphaComponent (0.2)
        progressBackGroundView.isUserInteractionEnabled = true
        progressBackGroundView.layer.zPosition = 1000
        let size = UIScreen.main.bounds.size
        
        progressBackGroundView.size = size
        progressBackGroundView.isHidden = true
        
        activityIndicator = MDCActivityIndicator ()
        activityIndicator.cycleColors = [BBYellowColor, BBGreenColor, BBPinColor]
        activityIndicator.indicatorMode = .indeterminate
        activityIndicator.strokeWidth = 5
        activityIndicator.layer.zPosition = 9999
        let viewWidth = self.view.bounds.width
        activityIndicator.radius = viewWidth * 0.05
        
        progressBackGroundView.addSubview (activityIndicator)
        activityIndicator.snp.makeConstraints { m in
            m.width.height.equalTo (viewWidth * 0.1)
            m.centerY.centerX.equalToSuperview ()
        }
        progressBackGroundView.isUserInteractionEnabled = true
        
        statusBarOverlayView = UIView ()
        statusBarOverlayView.backgroundColor = BBBlack2Color.withAlphaComponent (0.2)
        
        UIApplication.shared.statusBarView!.addSubview (statusBarOverlayView)
        
        if #available(iOS 13.0, *) {
            //nothings..
        } else {
            statusBarOverlayView.snp.makeConstraints { m in
                m.top.left.right.bottom.equalToSuperview ()
            }
        }
        
        
        statusBarOverlayView.isHidden = true
        UIApplication.shared.keyWindow?.addSubview (progressBackGroundView)
    }
    
    public func showProgress () {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating ()
            self.progressBackGroundView.isHidden = false
        }
    }
    
    public func hideProgress () {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating ()
            self.progressBackGroundView.isHidden = true
        }
    }
    func presentMainViewController() {
        let vc = MainTabViewController()
          if #available(iOS 13.0, *) {
            vc.modalPresentationStyle = .overFullScreen
        }
        let bvc = BaseNavigationController(rootViewController: vc)
        if #available(iOS 13.0, *) {
            bvc.modalPresentationStyle = .overFullScreen
        }
        if #available(iOS 13.0, *) {
            self.dismiss(animated: true, completion: {
                self.present(bvc, animated: true)
            })
        } else {
            self.navigationController?.dismiss(animated: true)
            self.present(bvc, animated: true)
        }
        
    }
    
    func setNavigationColor (color: UIColor) {
        navigationController?.navigationBar.backgroundColor = color
    }
    
    func setNaviTitle (title: String) {
        
        navigationItem.titleLabel.text = title
      navigationItem.titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
              navigationItem.titleLabel.textColor = BBBlack2Color
        
//        let image: UIImage = UIImage(named: "logo1")!
//             let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//             imageView.contentMode = .scaleAspectFit
//             imageView.image = image
//             self.navigationItem.titleView = imageView
        
    }
    
    func roundCorners(view :UIView, corners: CACornerMask, radius: CGFloat){
        view.clipsToBounds = true
        view.layer.cornerRadius = radius
        view.layer.maskedCorners = corners
    }
}

