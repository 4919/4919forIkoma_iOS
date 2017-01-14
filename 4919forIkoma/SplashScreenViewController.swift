//
//  SplashScreenViewController.swift
//  4919forIkoma
//
//  Created by Kawanaka Shogo on H29/01/14.
//  Copyright © 平成29年 Nara Institute of Science and Technology. All rights reserved.
//

import UIKit
import Firebase

class SplashScreenViewController: UIViewController {
    let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var splashImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in
            let isAnonymous = user!.isAnonymous
            self.appDelegate.uid = user!.uid
            
            print (isAnonymous)
            print (self.appDelegate.uid)
        })
        
        print("Appeared")
        UIView.animate(withDuration: 0.3, delay: 1.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.splashImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (Bool) in
        }
        
        UIView.animate(withDuration: 0.2, delay: 1.3, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            self.splashImageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            self.splashImageView.alpha = 0
        }) { (Bool) in
            self.splashImageView.removeFromSuperview()

//            let storyboard = UIStoryboard(name:"Main", bundle:Bundle.main)
//            let naviView = storyboard.instantiateInitialViewController() as! UINavigationController
//            let view = naviView.topViewController as! TodaysMenuViewController
//            self.navigationController?.pushViewController(view, animated: true)

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let nextVC = storyboard.instantiateViewController(withIdentifier: "todayMenu")
//            let view = nextVC.topViewController as! TodaysMenuViewController
//            self.navigationController?.pushViewController(view, animated: true)
            let navigationController = UINavigationController(rootViewController: nextVC)
            self.present(navigationController, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
