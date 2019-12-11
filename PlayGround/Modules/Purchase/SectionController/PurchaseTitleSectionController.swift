//
//  PurchaseTitleSectionController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import IGListKit

final class PurchaseTitleSectionController: ListSectionController{
    
    var data:PurchaseTitle?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: PurchaseTitleCell.self, for: self, at: index) as? PurchaseTitleCell else {
            fatalError()
        }
        cell.titleLabel.text = data?.title!
        if(data?.des?.count ?? 0 > 0) {
            cell.desLabel.isHidden = false
            cell.desLabel.text = data?.des!
        } else {
            cell.desLabel.isHidden = true
        }
        return cell
    }
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        return  CGSize(width: collectionContext!.containerSize.width, height: 56)
    }
    
    override func didUpdate(to object: Any) {
        data = object as? PurchaseTitle
    }
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        
    }
}
