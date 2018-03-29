//
//  User_Me.swift
//  BeSafe
//
//  Created by Yogesh Date on 20/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class User_Me: NSObject {

    var city_id             : Int?
    var country_id          : Int?
    var district_id         : Int?
    var email               : String?
    var gender              : String?
    var mobile              : String?
    var mobile_country_code : Int?
    var name                : String?
    var password            : String?
    var pincode             : String?
    var security_code       : String?
    var state_id            : Int?
    var street              : String?
    var term_and_condition  : String?
    var user_id             : Int?
    
    func initWithUserdict(_ dictBayList: [String : AnyObject]) -> User_Me {
        
        let user = User_Me()
        
        let cityId                  = dictBayList["country_id"] as? String ?? " "
        user.country_id             = Int(cityId) ?? 0
        let dic_id                  = dictBayList["district_id"] as? String ?? " "
        user.district_id            = Int(dic_id) ?? 0
        user.email                  = dictBayList["email"] as? String ?? ""
        user.gender                 = dictBayList["gender"] as? String ?? " "
        user.mobile                 = dictBayList["mobile"] as? String ?? " "
        user.name                   = dictBayList["name"] as? String ?? " "
        user.password               = dictBayList["password"] as? String ?? " "
        user.pincode                = dictBayList["pincode"] as? String ?? " "
        user.security_code          = dictBayList["security_code"] as? String ?? " "
        let mob_Id                  = dictBayList["mobile_country_code"] as? String ?? " "
        user.mobile_country_code    = Int(mob_Id) ?? 0
        let state_id                = dictBayList["state_id"] as? String ?? " "
        user.state_id               = Int(state_id) ?? 0
        let stateId                 = dictBayList["user_id"] as? String ?? " "
        user.user_id                = Int(stateId) ?? 0
        user.street                 = dictBayList["street"] as? String ?? " "
        user.term_and_condition     = dictBayList["term_and_co ndition"] as? String ?? " "
        
        return user
    }
}

