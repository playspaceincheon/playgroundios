//
//  DetailHeaderImageSectionController.swift
//  PlayGround
//
//  Created by kim jason on 04/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import IGListKit


final class DetailHeaderImageSectionController: ListSectionController{
    
    var data:Buildings?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: DetailHeaderImageCell.self, for: self, at: index) as? DetailHeaderImageCell else {
                   fatalError()
               }
    
        cell.desLabel.text = data?.buildingAddress
        var tagStr = ""
        for (index,value) in (data?.tagNames?.enumerated())! {
            tagStr += "#\(value) "
        }
        cell.titleLabel.text = data?.buildingName!
        cell.tagLabel.text = tagStr
        let url = URL(string: data!.buildingThumnail!)
        cell.buildingImageView.kf.setImage(with: url)
        
        return cell
    }
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        return  CGSize(width: collectionContext!.containerSize.width, height: 420)
    }
    
    override func didUpdate(to object: Any) {
        data = object as? Buildings
    }
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        //nothings..
        
    }
}
