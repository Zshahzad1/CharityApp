//
//  ViewController.swift
//  CharityApp
//
//  Created by Admin on 12/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    var widthTF = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UIDevice().type.rawValue)
        if UIDevice().type.rawValue == "iPhone 5S" || UIDevice().type.rawValue == "iPhone SE"
        {
            widthTF = usernameTF.frame.size.width - 50
        }
        else
        {
            widthTF = usernameTF.frame.size.width
        }
        
        usernameTF.delegate = self
        passwordTF.delegate = self
        var a = CGRect(x: 0, y: usernameTF.frame.size.height - 2, width: widthTF, height: 2)
        var A = UIView(frame: a)
        A.backgroundColor = #colorLiteral(red: 0.02007878199, green: 0.2526263595, blue: 0.5222046375, alpha: 1)
        usernameTF.addSubview(A)
        
         a = CGRect(x: 0, y: passwordTF.frame.size.height - 2, width: widthTF, height: 2)
         A = UIView(frame: a)
        A.backgroundColor = #colorLiteral(red: 0.02007878199, green: 0.2526263595, blue: 0.5222046375, alpha: 1)
        passwordTF.addSubview(A)
    }

    
    @IBAction func loginBTN(_ sender: UIButton) {
        SVProgressHUD.show(withStatus: "Verifying...")
        if (usernameTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
        {
            Alertbox(message: "Please Enter Username")
        }
      else if (passwordTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
        {
            Alertbox(message: "Please Enter Password")
        }
        else{
            let url = delegate.baseURL + "users/login?"
            print(url)
            let urlComponent = URLComponents(string: url)!
            var request = URLRequest(url: urlComponent.url!)
            request.httpMethod = "POST"
            let bodyData = "email=\(usernameTF.text!)&password=\(passwordTF.text!)"
            request.httpBody = bodyData.data(using: String.Encoding.utf8)
           SVProgressHUD.dismiss()
            Alamofire.request(request).validate().responseJSON { response in
                print(response.result)
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let result = json["result"]
                    print(result)
                    self.SAlertbox(message: "Login Successfully")
                case .failure(let error):
                    self.Alertbox(message: "Something went wrong with email or password")
                    print(error)
                }
            }
            SVProgressHUD.dismiss()
        }
    }
    @IBAction func forgetPassBTN(_ sender: UIButton) {
    
    }
  
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func SAlertbox(message: String)
    {
        let alert = UIAlertController(title: "Success", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (UIAlertAction) in
            self.performSegue(withIdentifier: "home", sender: self)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func Alertbox(message: String)
    {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    @IBOutlet weak var signupBTN: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

public enum Model : String {
    case simulator   = "simulator/sandbox",
    iPod1            = "iPod 1",
    iPod2            = "iPod 2",
    iPod3            = "iPod 3",
    iPod4            = "iPod 4",
    iPod5            = "iPod 5",
    iPad2            = "iPad 2",
    iPad3            = "iPad 3",
    iPad4            = "iPad 4",
    iPhone4          = "iPhone 4",
    iPhone4S         = "iPhone 4S",
    iPhone5          = "iPhone 5",
    iPhone5S         = "iPhone 5S",
    iPhone5C         = "iPhone 5C",
    iPadMini1        = "iPad Mini 1",
    iPadMini2        = "iPad Mini 2",
    iPadMini3        = "iPad Mini 3",
    iPadAir1         = "iPad Air 1",
    iPadAir2         = "iPad Air 2",
    iPadPro9_7       = "iPad Pro 9.7\"",
    iPadPro9_7_cell  = "iPad Pro 9.7\" cellular",
    iPadPro12_9      = "iPad Pro 12.9\"",
    iPadPro12_9_cell = "iPad Pro 12.9\" cellular",
    iPhone6          = "iPhone 6",
    iPhone6plus      = "iPhone 6 Plus",
    iPhone6S         = "iPhone 6S",
    iPhone6Splus     = "iPhone 6S Plus",
    iPhoneSE         = "iPhone SE",
    iPhone7          = "iPhone 7",
    iPhone7plus      = "iPhone 7 Plus",
    iPhone8          = "iPhone 8",
    iPhone8plus      = "iPhone 8 Plus",
    iPhoneX          = "iPhone X",
    unrecognized     = "?unrecognized?"
}

public extension UIDevice {
    public var type: Model {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
                
            }
        }
        var modelMap : [ String : Model ] = [
            "i386"      : .simulator,
            "x86_64"    : .simulator,
            "iPod1,1"   : .iPod1,
            "iPod2,1"   : .iPod2,
            "iPod3,1"   : .iPod3,
            "iPod4,1"   : .iPod4,
            "iPod5,1"   : .iPod5,
            "iPad2,1"   : .iPad2,
            "iPad2,2"   : .iPad2,
            "iPad2,3"   : .iPad2,
            "iPad2,4"   : .iPad2,
            "iPad2,5"   : .iPadMini1,
            "iPad2,6"   : .iPadMini1,
            "iPad2,7"   : .iPadMini1,
            "iPhone3,1" : .iPhone4,
            "iPhone3,2" : .iPhone4,
            "iPhone3,3" : .iPhone4,
            "iPhone4,1" : .iPhone4S,
            "iPhone5,1" : .iPhone5,
            "iPhone5,2" : .iPhone5,
            "iPhone5,3" : .iPhone5C,
            "iPhone5,4" : .iPhone5C,
            "iPad3,1"   : .iPad3,
            "iPad3,2"   : .iPad3,
            "iPad3,3"   : .iPad3,
            "iPad3,4"   : .iPad4,
            "iPad3,5"   : .iPad4,
            "iPad3,6"   : .iPad4,
            "iPhone6,1" : .iPhone5S,
            "iPhone6,2" : .iPhone5S,
            "iPad4,1"   : .iPadAir1,
            "iPad4,2"   : .iPadAir2,
            "iPad4,4"   : .iPadMini2,
            "iPad4,5"   : .iPadMini2,
            "iPad4,6"   : .iPadMini2,
            "iPad4,7"   : .iPadMini3,
            "iPad4,8"   : .iPadMini3,
            "iPad4,9"   : .iPadMini3,
            "iPad6,3"   : .iPadPro9_7,
            "iPad6,11"  : .iPadPro9_7,
            "iPad6,4"   : .iPadPro9_7_cell,
            "iPad6,12"  : .iPadPro9_7_cell,
            "iPad6,7"   : .iPadPro12_9,
            "iPad6,8"   : .iPadPro12_9_cell,
            "iPhone7,1" : .iPhone6plus,
            "iPhone7,2" : .iPhone6,
            "iPhone8,1" : .iPhone6S,
            "iPhone8,2" : .iPhone6Splus,
            "iPhone8,4" : .iPhoneSE,
            "iPhone9,1" : .iPhone7,
            "iPhone9,2" : .iPhone7plus,
            "iPhone9,3" : .iPhone7,
            "iPhone9,4" : .iPhone7plus,
            "iPhone10,1" : .iPhone8,
            "iPhone10,2" : .iPhone8plus,
            "iPhone10,3" : .iPhone8,
            "iPhone10,4" : .iPhone8plus,
            "iPhone10,5" : .iPhoneX,
            "iPhone10,6" : .iPhoneX
        ]
        
        if let model = modelMap[String.init(validatingUTF8: modelCode!)!] {
            return model
        }
        return Model.unrecognized
}
}
