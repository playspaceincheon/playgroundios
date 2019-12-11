//
//  BuildingListCell.swift
//  PlayGround
//
//  Created by kim jason on 09/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import SnapKit


class BuildingListCell: UITableViewCell {

    static let ID = "BuildingListCell"
    
    var buildingThumnail = UIImageView()
    var titleLabel:UILabel!
    var addressLabel:UILabel!
    var tagLabel:UILabel!
    
    required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
     }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = BBWhiteColor
        
        let line = UIView()
        line.backgroundColor = BBOptionDividerCellColor
        self.addSubview(line)
        
        line.snp.makeConstraints{ m in
            m.bottom.equalToSuperview()
            m.width.equalToSuperview()
            m.height.equalTo(1)
            m.centerX.equalToSuperview()
        }
        
        
        
        titleLabel = setLabel(title: "", size: 16, textColor: BBBlack2Color, textAlign: .left, isBold: true)
        
        addressLabel = setLabel(title: "", size: 12, textColor: BBGrey2Color, textAlign: .left, isBold: true)
        
         tagLabel = setLabel(title: "", size: 12, textColor: BBGrey2Color, textAlign: .left, isBold: true)
        
        buildingThumnail.backgroundColor = BBGrey2Color
        buildingThumnail.makeCorner(withRadius: 8)
        
        self.addSubview(titleLabel)
        self.addSubview(addressLabel)
        self.addSubview(tagLabel)
        self.addSubview(buildingThumnail)
        
        buildingThumnail.snp.makeConstraints{ m in
            m.width.equalTo(132)
            m.height.equalTo(88)
            m.centerY.equalToSuperview()
            m.left.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints{ m in
            m.left.equalTo(buildingThumnail.snp.right).offset(8)
            m.top.equalToSuperview().offset(16)
            m.right.equalToSuperview().offset(-8)
        }
        
        addressLabel.snp.makeConstraints{ m in
            m.left.equalTo(buildingThumnail.snp.right).offset(8)
            m.top.equalTo(titleLabel.snp.bottom).offset(8)
            m.right.equalToSuperview().offset(-8)
        }
        
        tagLabel.snp.makeConstraints{ m in
               m.left.equalTo(buildingThumnail.snp.right).offset(8)
               m.top.equalTo(addressLabel.snp.bottom).offset(8)
               m.right.equalToSuperview().offset(-8)
        }
        
    }
  
}
