//
//  TodaysMenuViewController.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/01/08.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//


import UIKit
import Firebase

class TodaysMenuViewController: UIViewController{
    
    @IBOutlet weak var naviBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var uid:String = ""
        let now = Date()
        
        /**日にちを取得**/
        let formatter = DateFormatter()
        let jaLocale = Locale(identifier: "ja_JP")
        formatter.locale = jaLocale
        formatter.dateFormat = "MM月dd日(E)"
        
        /**メニューバータイトル変更**/
        let todaysMenu:String! = (formatter.string(from: now))
        self.naviBar.title = todaysMenu
        
        if uid != String(true){
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            let isAnonymous = user!.isAnonymous
            uid = user!.uid

            print (isAnonymous)
            print (uid)
        })
        }
    }
    
    @IBAction func backToMonthly(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

