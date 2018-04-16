//
//  CharityVC.swift
//  CharityApp
//
//  Created by Admin on 15/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CharityVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    var projects = [String]()
    @IBOutlet weak var picker: UIPickerView!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return projects.count
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projects[row]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = delegate.baseURL + "projects/active/1"
        print(url)
        let urlComponent = URLComponents(string: url)!
        var request = URLRequest(url: urlComponent.url!)
        request.httpMethod = "GET"
        
        Alamofire.request(request).validate().responseJSON { response in
            print(response.result)
           
            let result = response.result.value as! NSDictionary
            let info = result["result"] as! NSArray
            var res = info[0] as! NSDictionary
            print(info)
            for i in 0..<info.count{
                res = info[i] as! NSDictionary
             self.projects.append(String(describing:res.value(forKey: "project_name")!))
            }
            print(self.projects)
            self.picker.reloadAllComponents()
        }
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
    }

    @IBAction func backBTN(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
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
