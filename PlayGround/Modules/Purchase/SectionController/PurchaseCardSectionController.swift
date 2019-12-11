//
//  PurchaseCardSectionController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import IGListKit

final class PurchaseCardSectionController: ListSectionController{
  
    var data:PurchaseCard?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: PurchaseCardCell.self, for: self, at: index) as? PurchaseCardCell else {
                         fatalError()
                     }
        cell.titleLabel.text = data?.title!
        if(data?.des?.count ?? 0 > 0) {
            cell.desLabel.text = data?.des!
            cell.desLabel.isHidden = false
        } else {
            cell.desLabel.isHidden = true
        }
        cell.layoutEdgeInsets = inset
        return cell
    }
    

    override func sizeForItem(at index: Int) -> CGSize {
        return  CGSize(width: collectionContext!.containerSize.width, height: 56)
    }
    
    override func didUpdate(to object: Any) {
       data = object as? PurchaseCard
    }
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {

    }
}
