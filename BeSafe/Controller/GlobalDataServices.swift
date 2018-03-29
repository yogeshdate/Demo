//
//  GlobalDataServices.swift
//  BeSafe
//
//  Created by Yogesh Date on 20/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class GlobalDataServices: NSObject {
    
    /* **********    Methods    ********************** */
    static let sharedInstance : GlobalDataServices = {
        let instance = GlobalDataServices()
        return instance
    }()
    
    // database path
    var user_Me : User_Me!
    
    //NSUSERDEFAULT 
    func insertNewUser(user : User_Me) {
        
            let userObj = UserDefaults.standard
        
            userObj.set(user.country_id,           forKey: "country_id")
            userObj.set(user.district_id,          forKey: "district_id")
            userObj.set(user.email,                forKey: "email")
            userObj.set(user.gender,               forKey: "gender")
            userObj.set(user.mobile,               forKey: "mobile")
            userObj.set(user.country_id,           forKey: "country_id")
            userObj.set(user.mobile_country_code,  forKey: "mobile_country_code")
            userObj.set(user.name,                 forKey: "name")
            userObj.set(user.password,             forKey: "password")
            userObj.set(user.pincode,              forKey: "pincode")
            userObj.set(user.security_code,        forKey: "security_code")
            userObj.set(user.state_id,             forKey: "state_id")
            userObj.set(user.street,               forKey: "street")
            userObj.set(user.term_and_condition,   forKey: "term_and_condition")
            userObj.set(user.user_id,              forKey: "user_id")
            GlobalDataServices.sharedInstance.user_Me = user
    }

    func deleteUserinfo() {

            let userObj = UserDefaults.standard
            let dictionary = userObj.dictionaryRepresentation()
            dictionary.keys.forEach { key in
                userObj.removeObject(forKey: key)
            }
    }


    func checkUserObj()->User_Me {

            let user = User_Me()
            let userObj = UserDefaults.standard
            user.country_id          = userObj.integer(forKey:"country_id")
            user.district_id         = userObj.integer(forKey:"district_id")
            user.email               = userObj.string(forKey:"email")
            user.gender              = userObj.string(forKey:"gender")
            user.mobile              = userObj.string(forKey:"mobile")
            user.country_id          = userObj.integer(forKey:"country_id")
            user.mobile_country_code = userObj.integer(forKey:"mobile_country_code")
            user.name                = userObj.string(forKey:"name")
            user.password            = userObj.string(forKey:"password")
            user.pincode             = userObj.string(forKey:"pincode")
            user.security_code       = userObj.string(forKey:"security_code")
            user.state_id            = userObj.integer(forKey:"state_id")
            user.street              = userObj.string(forKey:"street")
            user.term_and_condition  = userObj.string(forKey:"term_and_condition")
            user.user_id             = userObj.integer(forKey:"user_id")

            GlobalDataServices.sharedInstance.user_Me = user
            return user
    }

    

}
