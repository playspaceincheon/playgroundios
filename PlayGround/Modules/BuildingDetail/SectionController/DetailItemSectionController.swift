//
//  DetailItemSectionController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import IGListKit
import Kingfisher
protocol ItemClickedDelegate:class {
    func ItemClicked(data:BuildingItems)
}


final class DetailItemSectionController: ListSectionController{
    weak var delegate:ItemClickedDelegate?
    
    var data:BuildingItems?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: DetailItemCell.self, for: self, at: index) as? DetailItemCell else {
                         fatalError()
                     }
          
        cell.itemImageView.contentMode = .scaleAspectFill
        cell.itemImageView.backgroundColor = BBGrey3Color.withAlphaComponent(0.6)
        let url = URL(string:(data?.itemThumnail!)!)
        cell.itemImageView.kf.setImage(with: url)
        cell.priceLabel.text = data?.itemPrice!
        cell.titleLabel.text = data?.itemName!
        cell.desLabel.text = data?.itemDes!
        if(data!.isSelected) {
            cell.backgroundColor = BBYellowColor.withAlphaComponent(0.4)
        } else {
            cell.backgroundColor = BBWhiteColor
        }
       cell.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didSelectCell))
         cell.addGestureRecognizer(gesture)
        
        return cell
    }
    
    @objc func didSelectCell() {
               delegate?.ItemClicked(data: self.data!)
      }
    override func sizeForItem(at index: Int) -> CGSize {
        return  CGSize(width: collectionContext!.containerSize.width, height: 152)
    }
    
    override func didUpdate(to object: Any) {
       data = object as? BuildingItems
    }
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        delegate?.ItemClicked(data: self.data!)
    }
}
