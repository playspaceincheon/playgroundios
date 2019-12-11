//
//  EventSectionController.swift
//  PlayGround
//
//  Created by kim jason on 10/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//


import Foundation
import IGListKit


final class EventSectionConttroller: ListSectionController{
    
    var data:Events?
    
    override init() {
        super.init()
        inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(of: EventCell.self, for: self, at: index) as? EventCell else {
                   fatalError()
               }
    
        cell.imageView.image = data?.thumnailImage!
        cell.titleLabel.text = data?.title!
        cell.desLabel.text = data?.des!
        
        return cell
    }
    
    
    override func sizeForItem(at index: Int) -> CGSize {
        return  CGSize(width: collectionContext!.containerSize.width, height: 550)
    }
    
    override func didUpdate(to object: Any) {
        data = object as? Events
    }
    
    func didSelect(_ sectionController: ListSingleSectionController, with object: Any) {
        //nothings..
        
    }
}
