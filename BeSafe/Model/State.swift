//
//  State.swift
//  BeSafe
//
//  Created by Yogesh Date on 27/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class State: NSObject {
    
    var state_id   : Int?
    var state_name : String?
    var country_id : Int?
    
    func initWithStateName(_ dict :[String:AnyObject]) -> State {
        
        let state = State()
        let stringState  = dict["state_id"] as? String ?? ""
        state.state_id   = Int(stringState) ?? -1
        state.state_name = dict["state_name"] as? String ?? ""
        let StringCid    = dict["country_id"] as? String ?? ""
        state.country_id = Int(StringCid) ?? -1
        
        return state
    }
}

