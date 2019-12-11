//
//  ListViewController.swift
//  PlayGround
//
//  Created by kim jason on 26/10/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import SnapKit
import UIKit


class ListViewController: BaseViewController{

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.preapreViews()
    }


}


extension ListViewController {
    func preapreViews() {
        let text = setLabel(title: "신청내역", size: 12, textColor: BBBlack2Color, textAlign: .center)
        
        self.view.addSubview(text)
        text.snp.makeConstraints{ m in
            m.centerX.centerY.equalToSuperview()
        }
        
        
    }
    
}
