//
//  DetailDesSectionController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation
import IGListKit

final class DetailDesSectionController: ListSectionController{
    
    var data:Descriptions?
    
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {        
        guard let cell = collectionContext?.dequeueReusableCell(of: DetailDesCell.self, for: self, at: index) as? DetailDesCell else {
                        fatalError()
                    }
        
        cell.desLabel.text = data?.des!
        cell.titleLabel.text = data?.desTitle!
        
        return cell
    }
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        if(((data?.des!.countInstances(of: "\n"))!) >= 2 ) {
          return  CGSize(width: collectionContext!.containerSize.width, height: 180)
        } else {
          return  CGSize(width: collectionContext!.containerSize.width, height: 100)
        }

    }
    
    override func didUpdate(to object: Any) {
        data = object as? Descriptions
    }
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        
        
    }
    
}
