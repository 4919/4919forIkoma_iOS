//
//  ScheduleCell.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/01/12.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//

import UIKit

class ScheduleCell: UITableViewCell {
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(_ menuList:MenuList){
        menuLabel.text = menuList.menuName
        menuImage.image = UIImage(named: menuList.imageName)
    }

}
