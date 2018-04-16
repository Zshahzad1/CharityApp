//
//  HomeVC.swift
//  CharityApp
//
//  Created by Admin on 15/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON

class HomeVC: UIViewController {
    @IBOutlet weak var slideView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var fajr: UILabel!
    @IBOutlet weak var dhuhr: UILabel!
    @IBOutlet weak var asr: UILabel!
    @IBOutlet weak var maghrib: UILabel!
    @IBOutlet weak var isha: UILabel!
    @IBOutlet weak var qibla_direction: UILabel!
    @IBOutlet weak var empty_circle: UIImageView!
    @IBOutlet weak var fill_Circle: UIImageView!

     let delegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Plase Wait...")

        let url = "http://muslimsalat.com/islamabad/daily.json?key=3db85bdcbcd1a5caebfb584a79eaf317"
        print(url)
        let urlComponent = URLComponents(string: url)!
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "GET"
        
        Alamofire.request(request).validate().responseJSON { response in
            print(response.result)
            SVProgressHUD.dismiss()
            let result = response.result.value as! NSDictionary
            let direction = result["qibla_direction"]
            self.qibla_direction.text = String(describing:direction!)
            let info = result["items"] as! NSArray
            var res = info[0] as! NSDictionary
            print(info)
            for i in 0..<info.count{
                res = info[i] as! NSDictionary
                self.dhuhr.text = String(describing: res.value(forKey: "dhuhr")!)
                self.fajr.text = String(describing: res.value(forKey: "fajr")!)
                self.asr.text = String(describing: res.value(forKey: "asr")!)
                self.maghrib.text = String(describing: res.value(forKey: "maghrib")!)
                self.isha.text = String(describing: res.value(forKey: "isha")!)
            }
        }
        SVProgressHUD.dismiss()
    }
    
    @IBAction func leftBTN(sender: UISwipeGestureRecognizer){
        slideView.isHidden = false
        mainView.isHidden = true
        empty_circle.image = UIImage.init(named: "fill_circle.png")
        fill_Circle.image = UIImage.init(named: "circle.png")
    }
    
    @IBAction func rightBTN(sender: UISwipeGestureRecognizer){
        slideView.isHidden = true
        mainView.isHidden = false
        empty_circle.image = UIImage.init(named: "circle.png")
        fill_Circle.image = UIImage.init(named: "fill_circle.png")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
