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
    
    /** MenuImage**/
    @IBOutlet weak var stapleImg: UIImageView!
    @IBOutlet weak var mainDishImg: UIImageView!
    @IBOutlet weak var sideDishImg: UIImageView!
    @IBOutlet weak var soupImg: UIImageView!
    @IBOutlet weak var dezertImg: UIImageView!
    
    /** SubData **/
    @IBOutlet weak var energyNum: UILabel!
    @IBOutlet weak var yellowPoint: UILabel!
    @IBOutlet weak var greenPoint: UILabel!
    @IBOutlet weak var redPoint: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        /**日にちを取得**/
        let formatter = DateFormatter()
        let jaLocale = Locale(identifier: "ja_JP")
        formatter.locale = jaLocale
        formatter.dateFormat = "MM月dd日(E)"
        
        /**メニューバータイトル変更**/
        let todaysMenu:String! = (formatter.string(from: now))
        self.naviBar.title = todaysMenu
        
        if appDelegate.uid != String(true){
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            let isAnonymous = user!.isAnonymous
            appDelegate.uid = user!.uid

            print (isAnonymous)
            print (appDelegate.uid)
        })
        }
    }
    
    @IBAction func backToMonthly(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /** Button Tap **/
    @IBAction func stapleBtn(_ sender: Any) {
        
    }
    
    @IBAction func mainDishBtn(_ sender: Any) {
    }
    
    @IBAction func sideDishBtn(_ sender: Any) {
    }
    
    @IBAction func soupDishBtn(_ sender: Any) {
    }
    
    @IBAction func dezertBtn(_ sender: Any) {
    }
    
}

