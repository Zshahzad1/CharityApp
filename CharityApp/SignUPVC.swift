//
//  SignUPVC.swift
//  CharityApp
//
//  Created by Admin on 15/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import SVProgressHUD

class SignUPVC: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var fnameTF: UITextField!
    
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var countryLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var addressTF: UITextField!
    var widthTF = CGFloat()
    var locationManager = CLLocationManager()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fnameTF.delegate = self
        lnameTF.delegate = self
        emailTF.delegate = self
        passwordTF.delegate = self
        phoneTF.delegate = self
        addressTF.delegate = self
        
        print(UIDevice().type.rawValue)
        if UIDevice().type.rawValue == "iPhone 5S" || UIDevice().type.rawValue == "iPhone SE"
        {
            widthTF = fnameTF.frame.size.width - 50
        }
        else
        {
            widthTF = fnameTF.frame.size.width
        }
        fieldstyle()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startMonitoringSignificantLocationChanges()
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
            }
        } else {
            print("Location services are not enabled")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last!
       locationManager.stopUpdatingLocation()
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location as! CLLocation) { (placemarks, error) in
            // Process Response
            if let error = error {
                print("Unable to Reverse Geocode Location (\(error))")
            } else {
                if let placemarks = placemarks, let placemark = placemarks.first {
                    self.countryLbl.text = placemark.country
                    self.cityLbl.text = placemark.postalCode
                } else {
                    self.countryLbl.text = "No Matching Addresses Found"
                }
            }
        }
       
    }
    
    @IBAction func registerBTN(_ sender: UIButton) {
        if (fnameTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
        {
            Alertbox(message: "Please Enter First Name")
        }
        else if (lnameTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
        {
            Alertbox(message: "Please Enter Last Name")
        }
        else if (emailTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
        {
            Alertbox(message: "Please Enter Email")
        }
        else if (passwordTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
        {
            Alertbox(message: "Please Enter Password")
        }
        else if (phoneTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
        {
            Alertbox(message: "Please Enter Phone Number")
        }
        else if (addressTF.text?.trimmingCharacters(in: .whitespaces).isEmpty)!
        {
            Alertbox(message: "Please Enter Address")
        }
        else{
            let url = delegate.baseURL + "users/register?"
            print(url)
            let urlComponent = URLComponents(string: url)!
            var request = URLRequest(url: urlComponent.url!)
            request.httpMethod = "POST"
            let bodyData = "user_ref_id=&registrar_id= &user_first_name =\(fnameTF.text!)&user_last_name=\(lnameTF.text!)&user_mobile=\(phoneTF.text!)&user_email=\(emailTF.text!)&user_add_cont=\(countryLbl.text!)&user_add_state=\(cityLbl.text!)&user_add_post_code=&user_add_city=\(cityLbl.text!)&user_add_st=\(addressTF.text!)&user_password=\(passwordTF.text!)&org_id=1"
            request.httpBody = bodyData.data(using: String.Encoding.utf8)
            
            Alamofire.request(request).validate().responseJSON { response in
                print(response.result)
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    let result = json["msg"]
                    print(result)
                    self.Alertbox(message: "User has been Registered Successfully")
                case .failure(let error):
                    self.Alertbox(message: "Something went wrong")
                    print(error)
                }
            }
            
        }
    }
    
    @IBAction func backBTN(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func Alertbox(message: String)
    {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func fieldstyle()
    {
        var a = CGRect(x: 0, y: fnameTF.frame.size.height - 2, width: widthTF, height: 2)
        var A = UIView(frame: a)
        A.backgroundColor = #colorLiteral(red: 0.02007878199, green: 0.2526263595, blue: 0.5222046375, alpha: 1)
        fnameTF.addSubview(A)
        
        a = CGRect(x: 0, y: lnameTF.frame.size.height - 2, width: widthTF, height: 2)
        A = UIView(frame: a)
        A.backgroundColor = #colorLiteral(red: 0.02007878199, green: 0.2526263595, blue: 0.5222046375, alpha: 1)
        lnameTF.addSubview(A)
        
        a = CGRect(x: 0, y: emailTF.frame.size.height - 2, width: widthTF, height: 2)
        A = UIView(frame: a)
        A.backgroundColor = #colorLiteral(red: 0.02007878199, green: 0.2526263595, blue: 0.5222046375, alpha: 1)
        emailTF.addSubview(A)
        
        a = CGRect(x: 0, y: passwordTF.frame.size.height - 2, width: widthTF, height: 2)
        A = UIView(frame: a)
        A.backgroundColor = #colorLiteral(red: 0.02007878199, green: 0.2526263595, blue: 0.5222046375, alpha: 1)
        passwordTF.addSubview(A)
        
        a = CGRect(x: 0, y: phoneTF.frame.size.height - 2, width: widthTF, height: 2)
        A = UIView(frame: a)
        A.backgroundColor = #colorLiteral(red: 0.02007878199, green: 0.2526263595, blue: 0.5222046375, alpha: 1)
        phoneTF.addSubview(A)
        
        a = CGRect(x: 0, y: addressTF.frame.size.height - 2, width: widthTF, height: 2)
        A = UIView(frame: a)
        A.backgroundColor = #colorLiteral(red: 0.02007878199, green: 0.2526263595, blue: 0.5222046375, alpha: 1)
        addressTF.addSubview(A)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
