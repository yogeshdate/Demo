//
//  City.swift
//  BeSafe
//
//  Created by Yogesh Date on 27/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class City: NSObject {

    var id          : Int?
    var city_name   : String?
    var district_id : Int?
    
    func initWithCityName(_ dict :[String:AnyObject]) -> City {
        
        let cityObj = City()
        
        let stringState         = dict["id"] as? String ?? ""
        cityObj.id              = Int(stringState) ?? -1
        cityObj.city_name       = dict["city_name"] as? String ?? ""
        let StringCid           = dict["district_id"] as? String ?? ""
        cityObj.district_id     = Int(StringCid) ?? -1
        
        return cityObj
    }
}


