//
//  District.swift
//  BeSafe
//
//  Created by Yogesh Date on 27/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class District: NSObject {

    var district_id        : Int?
    var districtName       : String?
    var district_states_id : Int?
    
    func initWithDistrictName(_ dict :[String:AnyObject]) -> District {
        
        let dist = District()
        
        let stringState         = dict["district_id"] as? String ?? ""
        dist.district_id        = Int(stringState) ?? -1
        dist.districtName       = dict["districtName"] as? String ?? ""
        let StringCid           = dict["district_states_id"] as? String ?? ""
        dist.district_states_id = Int(StringCid) ?? -1
        
        return dist
    }
}
