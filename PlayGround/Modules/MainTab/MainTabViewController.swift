//
//  MainTabViewController.swift
//  PlayGround
//
//  Created by kim jason on 24/10/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import Tabman
import Pageboy
import SnapKit
import MaterialComponents
import Material
import FontAwesome_swift
import RevealingSplashView

class MainTabViewController: TabmanViewController {
    
    
    var fabButton = MDCFloatingButton ()
    
    lazy var viewControllers:[UIViewController] = {
        var tabs=[UIViewController]()
        tabs.append(HomeViewController())
        tabs.append(ListViewController())
        tabs.append(EventViewController())
        return tabs
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.prepareTitle()
        self.isScrollEnabled = false
        // Create bar
        let bar = TMBar.TabBar()
//        bar.layout.contentInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        bar.layout.transitionStyle = .progressive // Customize
        bar.scrollMode = .interactive
        
//        bar.fadesContentEdges = false
        bar.spacing = 120
        bar.buttons.customize{ (button) in
            button.selectedTintColor = BBYellowColor
        }
        bar.backgroundColor = BBWhiteColor
        bar.tintColor = BBYellowColor
        let systemBar = bar.systemBar()
        systemBar.backgroundStyle = .flat(color: BBWhiteColor)
   
        bar.translatesAutoresizingMaskIntoConstraints = true
        // Add to view
        addBar(bar, dataSource: self, at: .bottom)
        
        let bottomBG = UIView()
        bottomBG.backgroundColor = BBWhiteColor
        self.view.addSubview(bottomBG)
        bottomBG.snp.makeConstraints{ m in
            
            m.bottom.equalToSuperview()
            m.width.equalToSuperview()
            m.height.equalTo(34)
            m.centerX.equalToSuperview()
        }
        bottomBG.layer.zPosition = 99
        bottomBG.isHidden = DeviceManager.checkXDevice() ? false : true
        self.prepareFAB()
    }
}

extension MainTabViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func prepareTitle() {
        //        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.setNavigationColor(color: BBMainBackgroundColor)
        self.setNaviTitle(title: "노는공간")
    }
    func setNaviTitle (title: String) {
        
        navigationItem.titleLabel.text = title
        navigationItem.titleLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
        navigationItem.titleLabel.textColor = BBBlack2Color
        
//        
//        let image: UIImage = UIImage(named: "logo1")!
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        imageView.contentMode = .scaleAspectFit
//        imageView.image = image
//        self.navigationItem.titleView = imageView
    }
    
    
    func setNavigationColor (color: UIColor) {
        navigationController?.navigationBar.backgroundColor = color
    }
    
    func prepareFAB() {
        let plusImage = UIImage(named:"fab")
        
        fabButton.sizeToFit()
        fabButton.layer.masksToBounds = false
        
        fabButton.translatesAutoresizingMaskIntoConstraints = false
        //            fabButton.setImage(plusImage, for: .normal)
        
        fabButton.setBackgroundImage(plusImage, for: .normal)
        fabButton.backgroundColor = UIColor.clear
        fabButton.accessibilityLabel = "Create"
        
        self.view.addSubview(fabButton)
        
        fabButton.snp.makeConstraints{ m in
            m.width.height.equalTo(64)
            m.bottom.equalToSuperview().offset( (DeviceManager.checkXDevice() ? -40 : -8))
            m.centerX.equalToSuperview()
        }
        fabButton.layer.zPosition = 999
        fabButton.addTarget(self, action: #selector(fabButtonClicked), for: .touchUpInside)
    }
    
    @objc func fabButtonClicked() {
        let vc = FilterViewController()
        let bottomSheet: MDCBottomSheetController =
            MDCBottomSheetController(contentViewController: vc)
           bottomSheet.preferredContentSize.height = CGFloat(400)
        
        self.present(bottomSheet, animated: true)
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        switch index {
        case 0:
            return TMBarItem(title: "홈",
                             image: UIImage.fontAwesomeIcon(
                                name: .home,
                                style: .solid,
                                textColor: BBBlack2Color,
                                size: tabIconSize).withRenderingMode(.alwaysTemplate))
        case 1:
            return TMBarItem(title: "")
        case 2:
            return TMBarItem(title: "이벤트",
                             image: UIImage.fontAwesomeIcon(
                                name: .list,
                                style: .solid,
                                textColor: BBBlack2Color,
                                size: tabIconSize).withRenderingMode(.alwaysTemplate))
            
        default:
            return TMBarItem(title: "Page No. \(index + 1)",
                image: UIImage.fontAwesomeIcon(
                    name: .home,
                    style: .brands,
                    textColor: BBBlack2Color,
                    size: tabIconSize))
            
        }
    }
    
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        if(index == 1) {
            return viewControllers[2]
        } else {
            return viewControllers[index]
        }
        
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
}
