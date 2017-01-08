//
//  ViewController.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/01/07.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var menuLabel: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
//            let isAnonymous = user!.isAnonymous  // true
//            let uid = user!.uid
            
            let now = Date()
            
            let formatter = DateFormatter()
            let jaLocale = Locale(identifier: "ja_JP")
            formatter.locale = jaLocale
            formatter.dateFormat = "MM月dd日(E)"
            
//            print(formatter.string(from:now))
//            
//            let cal = Calendar.current
//            var dataComps = cal.dateComponents([.year, .month, .day, .hour, .minute], from: now)
            
            let todaysMenu:String! = (formatter.string(from: now))
            self.menuLabel.title = todaysMenu
            
//            print (isAnonymous)
//            print (uid)
        })
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

