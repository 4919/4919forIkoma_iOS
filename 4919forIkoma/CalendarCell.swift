//
//  CalendarCell.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/01/10.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    open var textLabel: UILabel!
    
    required init(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        // UILabelを生成
        textLabel = UILabel()
        textLabel.frame = CGRect(x: 0, y: 0, width:self.frame.width, height:self.frame.height)
        textLabel.layer.borderColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0).cgColor
        textLabel.layer.borderWidth = 5.0
        textLabel.backgroundColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        textLabel.textAlignment = .center
        
        // Cellに追加
        self.addSubview(textLabel!)
    }
    
}
