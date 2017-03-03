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
    @IBOutlet weak var drinkImg: UIImageView!
    
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
    
    /** Arrays **/
    var stapleAllergens:[String] = [String]()
    var stapleIngredients:[String] = [String]()
    var mainDishAllergens:[String] = [String]()
    var mainDishIngredients:[String] = [String]()
    var sideDishAllergens:[String] = [String]()
    var sideDishIngredients:[String] = [String]()
    var soupAllergens:[String] = [String]()
    var soupIngredients:[String] = [String]()
    var dezertAllergens:[String] = [String]()
    var dezertIngredients:[String] = [String]()
    var milkAllergens:[String] = ["乳"]
    var milkIngredients:[String] = ["ぎゅうにゅう"]
    
    var today:String! = ""
    
    // appDelegate を宣言
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
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
        self.todaymenu.text = todaysMenu

        // today = formatter_today.string(from: now)
        today = "170302"
        
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
        
        staple.isEnabled = false
        main_dish.isEnabled = false
        side_dish.isEnabled = false
        soup.isEnabled = false
        drink.isEnabled = false
        dezert.isEnabled = false
        
        let rootRef = FIRDatabase.database().reference()
        
        rootRef.child(today).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                // カロリー表示
                if snapshot.childSnapshot(forPath: "energy").exists(){
                    self.energyNum.text = String(describing: snapshot.childSnapshot(forPath: "energy").value!)
                }
                
                // 三元素表示
                if snapshot.childSnapshot(forPath: "threePoint").exists(){
                    var threePointArray:[String] = snapshot.childSnapshot(forPath: "threePoint").value! as! [String]
                    self.redPoint.text = String(describing: threePointArray[0])
                    self.greenPoint.text = String(describing: threePointArray[1])
                    self.yellowPoint.text = String(describing: threePointArray[2])
                }
                
                // 主菜表示
                if snapshot.childSnapshot(forPath: "menu_list").childSnapshot(forPath: "staple").exists(){
                    let staple_children:FIRDataSnapshot = snapshot.childSnapshot(forPath: "menu_list").childSnapshot(forPath: "staple")
                    self.staple.setTitle(String(describing:staple_children.childSnapshot(forPath: "name").value!), for: .normal)
                    self.drink.setTitle("ぎゅうにゅう", for: UIControlState.normal)
                    self.drinkImg.image = UIImage(named:"lunch_MilkBin")
                    self.staple.isEnabled = true
                    self.drink.isEnabled = true
                    
                    // 配列に保存
                    if staple_children.childSnapshot(forPath: "allergen").exists(){
                        for allergen in staple_children.childSnapshot(forPath: "allergen").value! as! [String]{
                            self.stapleAllergens.append(allergen)
                        }
                    }
                    if staple_children.childSnapshot(forPath: "ingredients").exists(){
                        for ingredient in staple_children.childSnapshot(forPath: "ingredients").value! as! [String]{
                            self.stapleIngredients.append(ingredient)
                        }
                    }
                    
                    // イラスト設定
                    if (String(describing: staple_children.childSnapshot(forPath: "name").value!).contains("ぱん") || String(describing: staple_children.childSnapshot(forPath: "name").value!).contains("パン")){
                        self.stapleImg.image = UIImage(named: "lunch_Koppepan.png")
                    } else if String(describing: staple_children.childSnapshot(forPath: "name").value!).contains("ナン"){
                        self.stapleImg.image = UIImage(named: "lunch_nan.png")
                    } else{
                        self.stapleImg.image = UIImage(named: "lunch_Rice.png")
                    }
                }else{
                    self.staple.setTitle("お休み", for: .normal)
                }
                
                //メインディッシュ
                if snapshot.childSnapshot(forPath: "menu_list").childSnapshot(forPath: "main_dish").exists(){
                    let main_children:FIRDataSnapshot = snapshot.childSnapshot(forPath: "menu_list").childSnapshot(forPath: "main_dish")
                    self.main_dish.setTitle(String(describing: main_children.childSnapshot(forPath: "name").value!), for: .normal)
                    self.main_dish.isEnabled = true
                    
                    // 配列に保存
                    if main_children.childSnapshot(forPath: "allergen").exists(){
                        for allergen in main_children.childSnapshot(forPath: "allergen").value! as! [String]{
                            self.mainDishAllergens.append(allergen)
                        }
                    }
                    if main_children.childSnapshot(forPath: "ingredients").exists(){
                        for ingredient in main_children.childSnapshot(forPath: "ingredients").value! as! [String]{
                            self.mainDishIngredients.append(ingredient)
                        }
                    }
                    // イラスト設定
                    if (String(describing: main_children.childSnapshot(forPath: "name").value!).contains("にく") || String(describing: main_children.childSnapshot(forPath: "name").value!).contains("肉") || String(describing: main_children.childSnapshot(forPath: "name").value!).contains("チキン")){
                        self.mainDishImg.image = UIImage(named: "lunch_Nikuryori.png")
                    }else if (String(describing: main_children.childSnapshot(forPath: "name").value!).contains("フライ") || String(describing: main_children.childSnapshot(forPath: "name").value!).contains("てんぷら") ){
                        self.mainDishImg.image = UIImage(named: "lunch_Fly.png")
                    }else if (String(describing: main_children.childSnapshot(forPath: "name").value!).contains("コロッケ")){
                        self.mainDishImg.image = UIImage(named: "lunch_Korokke.png")
                        
                    }else if (String(describing: main_children.childSnapshot(forPath: "name").value!).contains("いため")){
                        self.mainDishImg.image = UIImage(named: "lunch_YasaiItame.png")
                        
                    }else{
                        self.mainDishImg.image = UIImage(named: "lunch_Sakana.png")
                    }
                }
                
                // サイドディッシュ
                if snapshot.childSnapshot(forPath: "menu_list").childSnapshot(forPath: "side_dish").exists(){
                    let side_children:FIRDataSnapshot = snapshot.childSnapshot(forPath: "menu_list").childSnapshot(forPath: "side_dish")
                    self.side_dish.setTitle(String(describing: side_children.childSnapshot(forPath: "name").value!), for: .normal)
                    self.side_dish.isEnabled = true
                    
                    // 配列に保存
                    if side_children.childSnapshot(forPath: "allergen").exists(){
                        for allergen in side_children.childSnapshot(forPath: "allergen").value! as! [String]{
                            self.sideDishAllergens.append(allergen)
                        }
                    }
                    if side_children.childSnapshot(forPath: "ingredients").exists(){
                        for ingredient in side_children.childSnapshot(forPath: "ingredients").value! as! [String]{
                            self.sideDishIngredients.append(ingredient)
                        }
                    }
                    
                    if (String(describing: side_children.childSnapshot(forPath: "name").value!).contains("コロッケ")){
                        self.sideDishImg.image = UIImage(named: "lunch_Korokke.png")
                    }else{
                        self.sideDishImg.image = UIImage(named: "lunch_Kobachi")
                    }
                    
                    
                    
                }
                
                // スープ
                if snapshot.childSnapshot(forPath: "menu_list").childSnapshot(forPath: "soup").exists(){
                    let soup_children:FIRDataSnapshot = snapshot.childSnapshot(forPath: "menu_list").childSnapshot(forPath: "soup")
                    self.soup.setTitle(String(describing: soup_children.childSnapshot(forPath: "name").value!), for: .normal)
                    self.soup.isEnabled = true
                    
                    // 配列に保存
                    if soup_children.childSnapshot(forPath: "allergen").exists(){
                        for allergen in soup_children.childSnapshot(forPath: "allergen").value! as! [String]{
                            self.soupAllergens.append(allergen)
                        }
                    }
                    if soup_children.childSnapshot(forPath: "ingredients").exists(){
                        for ingredient in soup_children.childSnapshot(forPath: "ingredients").value! as! [String]{
                            self.soupIngredients.append(ingredient)
                        }
                    }
                    
                    // イラスト設定
                    if (String(describing: soup_children.childSnapshot(forPath: "name").value!).contains("うどん") || String(describing: soup_children.childSnapshot(forPath: "name").value!).contains("メン") || String(describing: soup_children.childSnapshot(forPath: "name").value!).contains("めん")){
                        self.soupImg.image = UIImage(named: "lunch_Noodle.png")
                    }else if (String(describing: soup_children.childSnapshot(forPath: "name").value!).contains("スープ")){
                        self.soupImg.image = UIImage(named: "lunch_Soup.png")
                    }else{
                        self.soupImg.image = UIImage(named: "lunch_MisoSoup.png")
                    }
                }
                
                // デザート
                if snapshot.childSnapshot(forPath: "menu_list").childSnapshot(forPath: "dezert").exists(){
                    let dezert_children:FIRDataSnapshot = snapshot.childSnapshot(forPath: "menu_list").childSnapshot(forPath: "dezert")
                    self.dezert.setTitle(String(describing: dezert_children.childSnapshot(forPath: "name").value!), for: .normal)
                    self.dezert.isEnabled = true
                    
                    // 配列に保存
                    if dezert_children.childSnapshot(forPath: "allergen").exists(){
                        for allergen in dezert_children.childSnapshot(forPath: "allergen").value! as! [String]{
                            self.dezertAllergens.append(allergen)
                        }
                    }
                    if dezert_children.childSnapshot(forPath: "ingredients").exists(){
                        for ingredient in dezert_children.childSnapshot(forPath: "ingredients").value! as! [String]{
                            self.dezertIngredients.append(ingredient)
                        }
                    }
                    
                    // イラスト設定
                    if (String(describing: dezert_children.childSnapshot(forPath: "name").value!).contains("ヨーグルト") || String(describing: dezert_children.childSnapshot(forPath: "name").value!).contains("ゼリー")){
                        self.dezertImg.image = UIImage(named: "lunch_Jelly.png")
                    }else{
                        self.dezertImg.image = UIImage(named: "lunch_Dezert.png")
                    }
                }
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    /** Button Tap **/
    @IBAction func stapleBtn(_ sender: Any) {
        performSegue(withIdentifier: "menuDetail", sender: nil)
        appDelegate.allergens = stapleAllergens
        appDelegate.ingredients = stapleIngredients
    }
    
    @IBAction func mainDishBtn(_ sender: Any) {
        performSegue(withIdentifier: "menuDetail", sender: nil)
        appDelegate.allergens = mainDishAllergens
        appDelegate.ingredients = mainDishIngredients
    }
    
    @IBAction func sideDishBtn(_ sender: Any) {
        performSegue(withIdentifier: "menuDetail", sender: nil)
        appDelegate.allergens = sideDishAllergens
        appDelegate.ingredients = sideDishIngredients
    }
    
    @IBAction func soupDishBtn(_ sender: Any) {
        performSegue(withIdentifier: "menuDetail", sender: nil)
        appDelegate.allergens = soupAllergens
        appDelegate.ingredients = soupIngredients
    }
    
    @IBAction func dezertBtn(_ sender: Any) {
        performSegue(withIdentifier: "menuDetail", sender: nil)
        appDelegate.allergens = dezertAllergens
        appDelegate.ingredients = dezertIngredients
    }
    
    @IBAction func drinkBtn(_ sender: Any) {
        performSegue(withIdentifier: "menuDetail", sender: nil)
        appDelegate.allergens = milkAllergens
        appDelegate.ingredients = milkIngredients
    }
    
}

