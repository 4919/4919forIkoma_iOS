//
//  MonthlyMenuViewController.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/01/08.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//

import UIKit

extension UIColor {
    class func lightBlue() -> UIColor {
        return UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    }
    
    class func lightRed() -> UIColor {
        return UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
    }
}

class MonthlyMenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var naviBar: UINavigationItem!
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let dateManager = DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate = Date()
    var before:CalendarCell!
    var today: Date!
    
    let weekArray = ["日", "月", "火", "水", "木", "金", "土"]
    var menuList:[MenuList] = [MenuList]()
    
    // @IBOutlet weak var imageInCell: UIImageView!
    // @IBOutlet weak var labelInCell: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**日にちを取得**/
        let now = Date()
        let formatter = DateFormatter()
        let jaLocale = Locale(identifier: "ja_JP")
        formatter.locale = jaLocale
        formatter.dateFormat = "M"
        
        /**メニューバータイトル変更**/
        let todaysMenu:String! = (formatter.string(from: now))
        self.naviBar.title = todaysMenu + "月のメニュー"

        // CollectionViewの設定
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "cell")
        
        // TableViewの設定
        tableView.delegate = self
        tableView.dataSource = self
        
        setupMenuList("ごはん" , imageName: "lunch_Rice")
        setupMenuList("ししゃものかんろに" , imageName: "lunch_Sakana")
        setupMenuList("だいこんサラダ" , imageName: "lunch_Kobachi")
        setupMenuList("カレーうどん" , imageName: "lunch_Noodle")
        setupMenuList("ぎゅうにゅう" , imageName: "lunch_MilkBin")
        setupMenuList("みかん" , imageName: "lunch_Dezert")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let now = Date()
        let formatter = DateFormatter()
        let jaLocale = Locale(identifier: "ja_JP")
        formatter.locale = jaLocale
        formatter.dateFormat = "d"
        
        let today:String! = (formatter.string(from: now))
        print (today)
        
        let indexPath:IndexPath = [1 , Int(today)!-1 ]
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCell
        
        if(before != nil){
            before.textLabel.backgroundColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        }
        putBackgroundImage(cell)
        before = cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // CollectioViewの設定
    // 1
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    // 2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 7
        }else{
            return dateManager.daysAcquisition()
        }
    }
    // 3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCell
        
        // テキストカラー
        if (indexPath.row % 7 == 0){
            cell.textLabel.textColor = UIColor.lightRed()
        }else if (indexPath.row % 7 == 6){
            cell.textLabel.textColor = UIColor.lightBlue()
        }else{
            cell.textLabel.textColor = UIColor.gray
        }
        
        // テキスト位置
        if indexPath.section == 0{
            cell.textLabel.text = weekArray[indexPath.row]
        } else{
            cell.textLabel.text = dateManager.conversionDateFormat((indexPath as NSIndexPath) as IndexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height: CGFloat = width * 1.0
        
        print (indexPath)
        
        return CGSize(width: width, height: height)
    }
    
    
    // セルのタッチイベント
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        print (indexPath)
        let cell = collectionView.cellForItem(at: indexPath) as! CalendarCell
        // 曜日のセッションは丸印をつけれないようにする
        if (indexPath.section == 1){
            putBackgroundImage(cell)
            if (before != nil){
                if (cell != before){
                    before.textLabel.backgroundColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
                }
            }
        before = cell
        }
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    // セルの背景に丸印をつける
    func putBackgroundImage(_ cell : CalendarCell){
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width:self.collectionView.frame.width , height:self.collectionView.frame.height ))
        let image = UIImage(named: "circle")
        imageView.image = image
        imageView.alpha = 1.0
        cell.backgroundView = imageView
        
        cell.textLabel.backgroundColor = UIColor(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 0.1)
    }

    
    // TableViewの設定
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    // セクションの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(menuList.count)
        return menuList.count
        
    }
    
    // セル内部の設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print ("tableView Now")

        let cell: ScheduleCell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleCell
        cell.configureCell(menuList[indexPath.row])
        
        return cell
    }
    
    // データセットを作成
    func setupMenuList(_ menuName: String, imageName: String){
        let data = MenuList(menuName: menuName, imageName: imageName)
        menuList.append(data)
    }
    
    @IBAction func backToTodayMenu(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
