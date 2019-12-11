//
//  PurchaseImageSectionController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import IGListKit
import Kingfisher

final class PurchaseImageSectionController: ListSectionController{
  
    var data:PurchaseImage?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: PurchaseImageCell.self, for: self, at: index) as? PurchaseImageCell else {
                         fatalError()
                     }
        let urlStr = data?.thumnail ?? ""
        if(urlStr.count > 0 ) {
            let url = URL(string: urlStr)
           cell.buildingImageView.kf.setImage(with: url)
            cell.buildingImageView.contentMode = .scaleAspectFill
        } else {
            //nothings..
        }
       
        return cell
    }
    

    override func sizeForItem(at index: Int) -> CGSize {
        return  CGSize(width: collectionContext!.containerSize.width, height: 200)
    }
    
    override func didUpdate(to object: Any) {
       data = object as? PurchaseImage
    }
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {

    }
}
