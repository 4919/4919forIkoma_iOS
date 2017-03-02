//
//  DetailMenuViewController.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/03/02.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//

import UIKit

class DetailMenuViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource {
    // appDelegate を宣言
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // コレクション
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    // セットする値
    var ingredientsArray:[String] = [String]()
    var allergensArray:[String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ingredientsArray = appDelegate.ingredients
        allergensArray = appDelegate.allergens
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myTabCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allergensArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! CustomCollectionViewCell
        
        switch allergensArray[indexPath.row] {
        case "卵":
            cell.allergenImage.image = UIImage(named:"allergy_tamago.png")
            break
        case "乳":
            cell.allergenImage.image = UIImage(named:"allergy_milk.png")
            break
        case "小麦":
            cell.allergenImage.image = UIImage(named:"allergy_komugi.png")
            break
        case "そば":
            cell.allergenImage.image = UIImage(named:"allergy_soba.png")
            break
        case "落花生":
            cell.allergenImage.image = UIImage(named:"allergy_peanut.png")
            break
        case "えび":
            cell.allergenImage.image = UIImage(named:"allergy_ebi.png")
            break
        case "かに":
            cell.allergenImage.image = UIImage(named:"allergy_kani.png")
            break
        case "オレンジ":
            cell.allergenImage.image = UIImage(named:"allergy_mikan.png")
            break
        case "りんご":
            cell.allergenImage.image = UIImage(named:"allergy_ringo.png")
            break
        case "キウイ":
            cell.allergenImage.image = UIImage(named:"allergy_kiwi.png")
            break
        case "バナナ":
            cell.allergenImage.image = UIImage(named:"allergy_banana.png")
            break
        case "もも":
            cell.allergenImage.image = UIImage(named:"allergy_momo.png")
            break
        case "くるみ":
            cell.allergenImage.image = UIImage(named:"allergy_kurumi.png")
            break
        case "大豆":
            cell.allergenImage.image = UIImage(named:"allergy_daizu.png")
            break
        case "カシューナッツ":
            cell.allergenImage.image = UIImage(named:"allergy_cashew.png")
            break
        case "まつたけ":
            cell.allergenImage.image = UIImage(named:"allergy_matsutake.png")
            break
        case "やまいも":
            cell.allergenImage.image = UIImage(named:"allergy_yamaimo.png")
            break
        case "ごま":
            cell.allergenImage.image = UIImage(named:"allergy_goma.png")
            break
        case "ゼラチン":
            cell.allergenImage.image = UIImage(named:"allergy_gelatine.png")
            break
        case "牛肉":
            cell.allergenImage.image = UIImage(named:"allergy_gyuniku.png")
            break
        case "豚肉":
            cell.allergenImage.image = UIImage(named:"allergy_butaniku.png")
            break
        case "鶏肉":
            cell.allergenImage.image = UIImage(named:"allergy_toriniku.png")
            break
        case "あわび":
            cell.allergenImage.image = UIImage(named:"allergy_awabi.png")
            break
        case "いか":
            cell.allergenImage.image = UIImage(named:"allergy_ika.png")
            break
        case "いくら":
            cell.allergenImage.image = UIImage(named:"allergy_ikura.png")
            break
        case "さけ":
            cell.allergenImage.image = UIImage(named:"allergy_sake.png")
            break
        case "さば":
            cell.allergenImage.image = UIImage(named:"allergy_saba.png")
            break
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myTabCell", for: indexPath as IndexPath)
        
        cell.textLabel!.text = ingredientsArray[indexPath.row]
        
        return cell
    }
}
