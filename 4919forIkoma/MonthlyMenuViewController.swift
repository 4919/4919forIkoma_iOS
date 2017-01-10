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

class MonthlyMenuViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dateManager = DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate = NSDate()
    var today: NSDate!
    let weekArray = ["日", "月", "火", "水", "木", "金", "土"]
    
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    @IBOutlet weak var scheduleTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        calenderCollectionView.backgroundColor = UIColor.white
        
        collectionView.register(CalendarCell.self, forCellWithReuseIdentifier: "cell")
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        if appDelegate.count == 0 {
//            let todayMenuVC = TodaysMenuViewController()
//            self.navigationController?.pushViewController(todayMenuVC, animated: true)
//            
//            self.appDelegate.count += 1
//            
//            print (self.appDelegate.count)
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
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
            cell.textLabel.text = dateManager.conversionDateFormat(indexPath: indexPath as NSIndexPath)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height: CGFloat = width * 1.0
        
        return CGSize(width: width, height: height)
        
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
}
