//
//  PurchaseDesSectionController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import IGListKit

final class PurchaseDesSectionController: ListSectionController{
  
    var data:PurchaseDes?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: PurchaseDesCell.self, for: self, at: index) as? PurchaseDesCell else {
                         fatalError()
                     }
        cell.titleLabel.text = data?.title!
        if(data?.des?.count ?? 0 > 0) {
            cell.desLabel.text = data?.des!
            cell.desLabel.isHidden = false
        } else {
            cell.desLabel.isHidden = true
        }
        
        if(data!.isUnderLine) {
            cell.underLineDivider.isHidden = false
        } else {
            cell.underLineDivider.isHidden = true
        }
        cell.layoutIfNeeded()
        return cell
    }
    

    override func sizeForItem(at index: Int) -> CGSize {
        return  CGSize(width: UIScreen.main.bounds.width , height: 40)
    }
    
    override func didUpdate(to object: Any) {
       data = object as? PurchaseDes
    }
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {

    }
}
