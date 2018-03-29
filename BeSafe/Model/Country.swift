//
//  Country.swift
//  BeSafe
//
//  Created by Yogesh Date on 27/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class Country: NSObject {
    
    var country_code     : String?
    var countryName      : String?
    var country_id       : Int?
    
    func initWithCountrydict(_ dictBayList: [String : AnyObject]) -> Country {
        
        let country = Country()
        
        let idString         = dictBayList["country_id"] as? String ?? ""
        country.country_id   =  Int(idString) ?? -1
        country.country_code = dictBayList["country_code"] as? String ?? ""
        country.countryName  = dictBayList["countryName"] as? String ?? ""
        
        return country
    }
    
}
