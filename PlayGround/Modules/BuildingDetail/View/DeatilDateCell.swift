//
//  DeatilDateCell.swift
//  PlayGround
//
//  Created by kim jason on 03/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import Material
import SnapKit
import UIKit
import Localize_Swift
import FontAwesome_swift


final class DeatilDateCell: UICollectionViewCell {

        static let ID = "DeatilDateCell"
    
    lazy var calenderImage:UIImageView = {
        let imageView = UIImageView(image: UIImage.fontAwesomeIcon(name: .calendar, style: .solid, textColor: BBBlackColor, size: CGSize(width: 20, height: 20)))
        return imageView
    }()
    
    lazy var dateLabel:UILabel = {
        let label = setLabel(title: "", size: 16, textColor: BBBlackColor, textAlign: .left, numberOfLines: 0)
        return label
    }()
    
    lazy var resultDate:UILabel = {
        let label = setLabel(title: "", size: 16, textColor: BBBlackColor, textAlign: .left, numberOfLines: 0, isSemiBold:true)
        return label
    }()
    
    lazy var changeLabel:UILabel = {
       let label = setLabel(title: "변경", size: 16, textColor: BBYellowColor, textAlign: .left, numberOfLines: 0)
      return label
    }()
    
    lazy var bottomDivider:UIView = {
        let divider = UIView()
        divider.backgroundColor = BBTableHeaderDividerColor
        return divider
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.bounds
        self.prepareViews(bounds: bounds)
    }
    
    var dateRangeStr:String? {
        didSet {
            resultDate.text = dateRangeStr
        }
    }
    
    var dateResult:String? {
        didSet {
            resultDate.text = dateResult
        }
    }
}

extension DeatilDateCell {
    
    func prepareViews(bounds:CGRect) {
        self.addSubview(calenderImage)
        self.addSubview(dateLabel)
        self.addSubview(resultDate)
        self.addSubview(changeLabel)
        self.addSubview(bottomDivider)
        
        calenderImage.snp.makeConstraints{ m in
            m.centerY.equalToSuperview()
            m.width.height.equalTo(20)
            m.left.equalToSuperview().offset(16)
        }
        
        dateLabel.snp.makeConstraints{ m in
            m.centerY.equalToSuperview()
            m.left.equalTo(calenderImage.snp.right).offset(16)
        }
        
        resultDate.snp.makeConstraints{ m in
            m.centerY.equalToSuperview()
            m.left.equalTo(dateLabel.snp.right).offset(16)
        }
        
        changeLabel.snp.makeConstraints{ m in
            m.centerY.equalToSuperview()
            m.right.equalToSuperview().offset(-16)
        }
        
        bottomDivider.snp.makeConstraints{ m in
            m.width.equalToSuperview()
            m.centerX.equalToSuperview()
            m.bottom.equalToSuperview()
            m.height.equalTo(1)
        }
    }
}
