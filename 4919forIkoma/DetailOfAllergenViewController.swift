//
//  DetailOfAllergenViewController.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/01/12.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//

import UIKit

class DetailOfAllergenViewController: UIViewController {

    @IBOutlet weak var rakkasei_label: UILabel!
    @IBOutlet weak var nats_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rakkasei_label.adjustsFontSizeToFitWidth = true
        nats_label.adjustsFontSizeToFitWidth = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BackPage(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
