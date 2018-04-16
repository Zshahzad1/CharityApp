//
//  Register.swift
//  CharityApp
//
//  Created by Admin on 15/04/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
class Register{
    
    var fname:String?
    var lname:String?
    var email:String?
    var phone: String?
    var password:String?
    var country:String?
    var city:String?
    var address: String?
    
    init(fname : String, lname : String, email : String, phone : String, password: String, country: String, city: String, address: String)
    {
        self.fname = fname
        self.lname = lname
        self.email = email
        self.phone = phone
        self.password = password
        self.country = country
        self.city = city
        self.address = address
    }
}
