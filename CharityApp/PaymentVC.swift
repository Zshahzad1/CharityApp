//
//  PaymentVC.swift
//  CharityApp
//
//  Created by Admin on 15/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import Braintree
import BraintreeDropIn
class PaymentVC: UIViewController {

     let clientToken = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiI4OTQ1N2I4ZTE5MzE3MzVmZGQ1NzEyZWExY2UwZDIwZmM0NTdjZDcxMjY1MzcyNzkxOGRjMzA4ZGEzNjU5MzhhfGNyZWF0ZWRfYXQ9MjAxOC0wNC0xNVQxNDoxMDo1NC42MTY5NDAyNDArMDAwMFx1MDAyNm1lcmNoYW50X2lkPW1oNDRjazViODVia2J5ejhcdTAwMjZwdWJsaWNfa2V5PWprNWc1Y2p5dzNjdjh3d2oiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvbWg0NGNrNWI4NWJrYnl6OC9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJjaGFsbGVuZ2VzIjpbXSwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzL21oNDRjazViODVia2J5ejgvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vY2xpZW50LWFuYWx5dGljcy5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tL21oNDRjazViODVia2J5ejgifSwidGhyZWVEU2VjdXJlRW5hYmxlZCI6dHJ1ZSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImRpc3BsYXlOYW1lIjoiQ3Jlc2NlbnQgUmVsaWVmIExpbWl0ZWQiLCJjbGllbnRJZCI6IkFiWmIyZXFaNFRtVkxUTldYUUxjQnVDVGV1bExwWllvMWZRanRpUjZzOWRGQnpHa3FfblFacU01cEVKZTVnSmxGMnBKOWN0aDhMMzliY29UIiwicHJpdmFjeVVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS9wcCIsInVzZXJBZ3JlZW1lbnRVcmwiOiJodHRwOi8vZXhhbXBsZS5jb20vdG9zIiwiYmFzZVVybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9jaGVja291dC5wYXlwYWwuY29tIiwiZGlyZWN0QmFzZVVybCI6bnVsbCwiYWxsb3dIdHRwIjp0cnVlLCJlbnZpcm9ubWVudE5vTmV0d29yayI6ZmFsc2UsImVudmlyb25tZW50Ijoib2ZmbGluZSIsInVudmV0dGVkTWVyY2hhbnQiOmZhbHNlLCJicmFpbnRyZWVDbGllbnRJZCI6Im1hc3RlcmNsaWVudDMiLCJiaWxsaW5nQWdyZWVtZW50c0VuYWJsZWQiOnRydWUsIm1lcmNoYW50QWNjb3VudElkIjoiY3Jlc2NlbnRyZWxpZWZsaW1pdGVkIiwiY3VycmVuY3lJc29Db2RlIjoiQVVEIn0sIm1lcmNoYW50SWQiOiJtaDQ0Y2s1Yjg1YmtieXo4IiwidmVubW8iOiJvZmYifQ"
    override func viewDidLoad() {
        super.viewDidLoad()
       showDropIn(clientTokenOrTokenizationKey: "sandbox_jzhzgm38_w68dc8cnx29p389n")
        // Do any additional setup after loading the view.
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
                 result.paymentIcon
                 result.paymentOptionType = BTUIKPaymentOptionType.payPal
                 result.paymentDescription
            }
            controller.dismiss(animated: true, completion: nil)
        }
        self.present(dropIn!, animated: true, completion: nil)
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
