//
//  SettingMenuViewController.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/01/08.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//

import UIKit

class SettingMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToMothly(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
