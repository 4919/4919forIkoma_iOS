//
//  MenuModel.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/01/12.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//

import Foundation

class MenuList : NSObject{
    var menuName: String!
    var imageName: String!
    
    init(menuName: String, imageName: String) {
        self.menuName = menuName
        self.imageName = imageName
    }
}
