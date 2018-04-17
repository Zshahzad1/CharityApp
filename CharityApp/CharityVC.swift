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
import BraintreeDropIn
import Braintree

class CharityVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
   
    let checkoutStackView = UIStackView()
    let payButton = UIButton(type: .roundedRect)
    var paymentMethod : BTPaymentMethodNonce?
    
    
    var projects = [String]()
    var details = [String]()
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var DetailTV: UITextView!
    @IBOutlet weak var amountTF: UITextField!
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DetailTV.text = details[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return projects.count
    }
   
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return projects[row]
    }
    var widthTF = CGFloat()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIDevice().type.rawValue == "iPhone 5S" || UIDevice().type.rawValue == "iPhone SE"
        {
            widthTF = amountTF.frame.size.width - 50
        }
        else
        {
            widthTF = amountTF.frame.size.width
        }
        amountTF.delegate = self
        let a = CGRect(x: 0, y: amountTF.frame.size.height - 2, width: widthTF, height: 2)
        let A = UIView(frame: a)
        A.backgroundColor = #colorLiteral(red: 0.02007878199, green: 0.2526263595, blue: 0.5222046375, alpha: 1)
        amountTF.addSubview(A)
        
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
                self.details.append(String(describing: res.value(forKey: "project_breif")!))
            }
            self.DetailTV.text = self.details[0]
            print(self.projects)
            self.picker.reloadAllComponents()
        }
        
        self.picker.delegate = self
        self.picker.dataSource = self
        
    }

    @IBAction func donateBTN(_ sender: UIButton) {
        guard let paymentMethodNonce = self.paymentMethod?.nonce else {
            showDropIn(clientTokenOrTokenizationKey: "sandbox_bhvsdjw5_mh44ck5b85bkbyz8")
            return
        }
        createTransaction(params: ["payment_method_nonce" : paymentMethodNonce])
       
    }
    @IBAction func backBTN(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       textField.resignFirstResponder()
        return true
    }
    
    @objc func selectPaymentMethodAction() {
       
    }
    
    func showDropIn(clientTokenOrTokenizationKey: String) {
        let request =  BTDropInRequest()
        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
        { (controller, result, error) in
            if (error != nil) {
                print("ERROR")
            } else if (result?.isCancelled == true) {
                print("CANCELLED")
            } else if let result = result {
                // Use the BTDropInResult properties to update your UI
                self.paymentMethod = result.paymentMethod
                let selectedPaymentMethodIcon = result.paymentIcon
                let selectedPaymentMethodDescription = result.paymentDescription
                
                let paymentMethodStackView = UIStackView()
                self.checkoutStackView.insertArrangedSubview(paymentMethodStackView, at: self.checkoutStackView.arrangedSubviews.count-1)
                paymentMethodStackView.translatesAutoresizingMaskIntoConstraints = false
                paymentMethodStackView.axis  = .horizontal
                paymentMethodStackView.spacing = 20
                
                selectedPaymentMethodIcon.widthAnchor.constraint(equalToConstant: 45).isActive = true
                selectedPaymentMethodIcon.heightAnchor.constraint(equalToConstant: 29).isActive = true
                paymentMethodStackView.addArrangedSubview(selectedPaymentMethodIcon)
                
                let selectedPaymentMethodText = UILabel()
                selectedPaymentMethodText.numberOfLines = 0
                selectedPaymentMethodText.translatesAutoresizingMaskIntoConstraints = false
                selectedPaymentMethodText.textColor = UIColor.black
                selectedPaymentMethodText.text = selectedPaymentMethodDescription
                paymentMethodStackView.addArrangedSubview(selectedPaymentMethodText)
                
                self.payButton.setTitle("Buy Now", for: .normal)
                self.payButton.backgroundColor = UIColor.purple
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
    }
    
    func alert(message: String, title: String = "") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func createTransaction(params: Dictionary<String, Any>) {
        Alamofire.request("http://localhost:3000/payments/checkout", method: .post, parameters: params, encoding: JSONEncoding.default).responseJSON { response in
            if let JSON = response.result.value {
                self.alert(message: "JSON: \(JSON)")
            } else {
                self.alert(message: "FAILURE")
            }
        }
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
