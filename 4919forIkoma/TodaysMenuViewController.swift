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
    
    /** MenuImage **/
    @IBOutlet weak var stapleImg: UIImageView!
    @IBOutlet weak var mainDishImg: UIImageView!
    @IBOutlet weak var sideDishImg: UIImageView!
    @IBOutlet weak var soupImg: UIImageView!
    @IBOutlet weak var dezertImg: UIImageView!
    
    /** Menu List **/
    @IBOutlet weak var staple: UIButton!
    @IBOutlet weak var main_dish: UIButton!
    @IBOutlet weak var side_dish: UIButton!
    @IBOutlet weak var soup: UIButton!
    @IBOutlet weak var drink: UIButton!
    @IBOutlet weak var dezert: UIButton!
    
    /** SubData **/
    @IBOutlet weak var energyNum: UILabel!
    @IBOutlet weak var redPoint: UILabel!
    @IBOutlet weak var greenPoint: UILabel!
    @IBOutlet weak var yellowPoint: UILabel!
    
    // Label
    @IBOutlet weak var todaymenu: UILabel!
    @IBOutlet weak var stapleLabel: UILabel!
    @IBOutlet weak var dishLabel: UILabel!
    @IBOutlet weak var drinkLabel: UILabel!
    @IBOutlet weak var dezertLabel: UILabel!
    @IBOutlet weak var energy: UILabel!
    @IBOutlet weak var kcal: UILabel!
    
    
    
    var today:String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let now = Date()
        // let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        /**日にちを取得**/
        let formatter_bar = DateFormatter()
        let formatter_today = DateFormatter()
        let jaLocale = Locale(identifier: "ja_JP")
        formatter_bar.locale = jaLocale
        formatter_bar.dateFormat = "MM月dd日(E)"
        formatter_today.dateFormat = "YYMMdd"
        print(formatter_today.string(from: now))
        
        /**メニューバータイトル変更**/
        let todaysMenu:String! = (formatter_bar.string(from: now))
        self.naviBar.title = todaysMenu
        
        today = formatter_today.string(from: now)
//        let rootRef = FIRDatabase.database().reference()
//        rootRef.child(today).observeSingleEvent(of: .value, with: { (snapshot) in
//            print(snapshot.value!)
//        })
        
        todaymenu.adjustsFontSizeToFitWidth = true
        stapleLabel.adjustsFontSizeToFitWidth = true
        dishLabel.adjustsFontSizeToFitWidth = true
        drinkLabel.adjustsFontSizeToFitWidth = true
        dezertLabel.adjustsFontSizeToFitWidth = true
        energy.adjustsFontSizeToFitWidth = true
        kcal.adjustsFontSizeToFitWidth = true
        
        staple.titleLabel?.adjustsFontSizeToFitWidth = true
        main_dish.titleLabel?.adjustsFontSizeToFitWidth = true
        side_dish.titleLabel?.adjustsFontSizeToFitWidth = true
        soup.titleLabel?.adjustsFontSizeToFitWidth = true
        drink.titleLabel?.adjustsFontSizeToFitWidth = true
        dezert.titleLabel?.adjustsFontSizeToFitWidth = true
        energyNum.adjustsFontSizeToFitWidth = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let rootRef = FIRDatabase.database().reference()
        
        rootRef.child(today).child("energy").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
            self.energyNum.text = String(describing: snapshot.value!)
            }
        })
        rootRef.child(today).child("threePoint").observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.exists())
            if snapshot.exists(){
                var threePointArray:[String] = snapshot.value! as! [String]
                self.redPoint.text = String(describing: threePointArray[0])
                self.greenPoint.text = String(describing: threePointArray[1])
                self.yellowPoint.text = String(describing: threePointArray[2])
            }
            
        })
        
        // メニュー設定
        rootRef.child(today).child("menu_list").child("staple").child("name").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                self.staple.setTitle(String(describing: snapshot.value!), for: UIControlState.normal)
                self.drink.setTitle("ぎゅうにゅう", for: UIControlState.normal)
                // イラスト設定
                if (String(describing: snapshot.value!).contains("ぱん") || String(describing: snapshot.value!).contains("パン")){
                    self.stapleImg.image = UIImage(named: "lunch_Koppepan.png")
                }
            }
        })
        // メインディッシュ
        rootRef.child(today).child("menu_list").child("main_dish").child("name").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                self.main_dish.setTitle(String(describing: snapshot.value!), for: UIControlState.normal)
                // イラスト設定
                if (String(describing: snapshot.value!).contains("にく") || String(describing: snapshot.value!).contains("肉") || String(describing: snapshot.value!).contains("チキン")){
                    self.mainDishImg.image = UIImage(named: "lunch_Nikuryori.png")
                }else if (String(describing: snapshot.value!).contains("フライ") || String(describing: snapshot.value!).contains("てんぷら") ){
                    self.mainDishImg.image = UIImage(named: "lunch_Fly.png")
                }
            }
        })
        // サイドディッシュ
        rootRef.child(today).child("menu_list").child("side_dish").child("name").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                self.side_dish.setTitle(String(describing: snapshot.value!), for: UIControlState.normal)
            }
        })
        // スープ
        rootRef.child(today).child("menu_list").child("soup").child("name").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                self.soup.setTitle(String(describing: snapshot.value!), for: UIControlState.normal)
                // イラスト設定
                if (String(describing: snapshot.value!).contains("うどん") || String(describing: snapshot.value!).contains("メン") || String(describing: snapshot.value!).contains("めん")){
                    self.soupImg.image = UIImage(named: "lunch_Noodle.png")
                }else if (String(describing: snapshot.value!).contains("スープ")){
                    self.soupImg.image = UIImage(named: "lunch_Soup.png")
                }
            }
        })
        // デザート
        rootRef.child(today).child("menu_list").child("dezert").child("name").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                self.dezert.setTitle(String(describing: snapshot.value!), for: UIControlState.normal)
                self.dezertImg.image = UIImage(named: "lunch_Dezert.png")
            }
        })
    }

//    @IBAction func backToMonthly(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//    }
    
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

