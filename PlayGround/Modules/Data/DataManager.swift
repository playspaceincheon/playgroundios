//
//  DataManager.swift
//  PlayGround
//
//  Created by kim jason on 09/11/2019.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation



class DataManager {
    
    
    class func getDummyData() -> [Buildings] {
        let str = rawData
        let dummyData = DummyData(JSONString: str)
        return dummyData!.datas!
    }
    
}
