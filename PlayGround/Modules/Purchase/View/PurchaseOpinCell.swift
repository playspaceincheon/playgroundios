//
//  PurchaseOpinCell.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import Material
import SnapKit
import UIKit
import Localize_Swift
import FontAwesome_swift

final class PurchaseOpinCell: UICollectionViewCell {
    
    static let ID = "PurchaseOpinCell"
    
    
    lazy var sqaureO:UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderWidth = 1
        view.layer.borderColor = BBBlackColor.cgColor
        view.layer.cornerRadius = 4
        return view
    }()
    
    lazy var checkBoxImageView: UIImageView = {
        
        let imageView = UIImageView(image: UIImage.fontAwesomeIcon(name: .check, style: .solid, textColor: BBBlackColor, size: CGSize(width: 20, height: 20)))
        return imageView
    }()
    
    lazy var desLabel: UILabel = {
        
        let uiLabel = setLabel(title: "", size: 12, textColor: DetailDesTextColor, textAlign: .left)
        return uiLabel
        
    }()
    
    lazy var padingView:UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .clear
        return uiView
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        self.prepareViews(bounds: bounds)
        
    }
}

extension PurchaseOpinCell {
    
    func prepareViews(bounds:CGRect) {
        
        sqaureO.addSubview(self.checkBoxImageView)
        addSubview(self.desLabel)
        addSubview(self.sqaureO)
        
        
        self.sqaureO.snp.makeConstraints{ m in
            m.width.height.equalTo(24)
            m.centerY.equalToSuperview()
            
            m.left.equalToSuperview().offset(16)
        }
        
        self.checkBoxImageView.snp.makeConstraints{ m in
            m.centerY.centerX.equalToSuperview()
            m.width.height.equalTo(20)
        }
        
        self.desLabel.snp.makeConstraints{ m in
            m.centerY.equalToSuperview()
            m.left.equalTo(sqaureO.snp.right).offset(8)
        }
        
    }
}
