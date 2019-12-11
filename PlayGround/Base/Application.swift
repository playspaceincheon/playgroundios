//
//  Application.swift
//  PlayGround
//
//  Created by kim jason on 22/10/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import UIKit
import Material

final class Application {
    static let shared = Application()
    
    func configMainViewInterface(in window: UIWindow) {
          let vc = SplashViewController()
//          let vc = MainTabViewController()
//          let bvc = BaseNavigationController(rootViewController: vc)
          window.rootViewController = vc
          window.makeKeyAndVisible()
      }
}
