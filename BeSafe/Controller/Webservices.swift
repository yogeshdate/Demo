//
//  Webservices.swift
//  BeSafe
//
//  Created by Yogesh Date on 20/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import Alamofire
import Contacts

class Webservices: NSObject {

    /* **********   Singalton Methods    ****************** */
    static let sharedInstance : Webservices = {
        let instance = Webservices()
        
        return instance
    }()
    
    let headers = [
        "Content-Type":"application/x-www-form-urlencoded"
    ]
    
    // LOGIN
    func loginWithUser(withuserName username : String,
                       password   : String,
                       countryCode: String,
                       success    : @escaping (_: User_Me) -> Void,
                       failure    : @escaping (_: String) -> Void) {
        
        let parameters = [ "mobile"              : username,
                           "password"            : password,
                           "mobile_country_code" : countryCode
        ]
        Alamofire.request("\(WEB_API_URL)userlogin.php",
            method: .post, parameters: parameters,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
                
                response in
                print("Login Response = \(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let responseDict : [String : AnyObject] = response.result.value as! [String : AnyObject]
                    if responseDict[WEB_API_RESULT] as? String == WEB_API_SUCCESS {
                        
                        let resDict : [String : AnyObject] = responseDict[WEB_API_DATA] as! [String : AnyObject]
                        let aryList : NSArray = resDict[WEB_API_USER_DATA] as! NSArray
                        
                        let objUser = User_Me()
                        var obj = User_Me()
                        for i in 0..<aryList.count {
                            obj = objUser.initWithUserdict(aryList[i] as! [String : AnyObject])
                        }
                        success(obj)
                    }
                    else
                    {
                        let error = responseDict[WEB_API_STATUS] as! String
                        failure(error)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
            })
    }


    // forgot password sent to email
    func forgotUserPassword(_ email_id : String,
                            success : @escaping (_: String) -> Void,
                            failure : @escaping (_: String) -> Void) {
        
        let parameter = ["email" : email_id]
        Alamofire.request("\(WEB_API_URL)forgotpassword.php",
            method: .post,
            parameters: parameter,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
                response in
                //print("\n Response =\(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let responseDict:[String:Any] = response.result.value as! [String : Any]
                    if responseDict[WEB_API_RESULT] as? String == WEB_API_SUCCESS {
                        success(responseDict["status"] as! String)
                    }else{
                        let string = responseDict[WEB_API_RESULT] as? String
                        success(string!)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
            })
    }
        
    // SIGN UP check mobile numner is exist or not
    func checkMobileNumber(_ mobile_No : String,
                           success : @escaping (_: String) -> Void,
                           failure : @escaping (_: String) -> Void) {
        
        let parameter = ["mobile" : mobile_No]
        Alamofire.request("\(WEB_API_URL)checkMobile.php",
            method: .post,
            parameters: parameter,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
                
                response in
                //print("\n Response =\(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let responseDict:[String:Any] = response.result.value as! [String : Any]
                    if responseDict[WEB_API_RESULT] as? String == WEB_API_SUCCESS {
                        //let string = responseDict[WEB_API_RESULT] as? String
                        failure("mobile number already exists.")
                    }else{
                        let string = responseDict[WEB_API_RESULT] as? String
                        success(string!)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
            })
    }

    // send otp to your mobile
    func sendSmsBash(_ mobile : String,
                     mobile_country_code : String,
                     text : String,
                     success : @escaping(_ : String) -> Void,
                     failure : @escaping(_ : String) -> Void) {

         let parameter = [ "mobile" : mobile,
                           "mobile_country_code" : mobile_country_code,
                           "text"  : text
            ] 

        Alamofire.request("\(WEB_API_URL)SendSmsBash.php",
            method: .post,
            parameters: parameter,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
                
                response in
                print("District = \(String(describing: response.result.value))")
                if response.result.isSuccess {
                   success("OTP send Successfully")
                }
                if response.result.isFailure {
                    success("OTP send Successfully")
                }
            })

    }
    
    // create new user in to system
    func registerNewUser(_ name          : String,
                         mobile_country_code : String,
                         mobile           : String,
                         password         : String,
                         email            : String,
                         gender           : String,
                         country_id       : Int,
                         state_id         : Int,
                         city_id          : Int,
                         district_id      : Int,
                         street           : String,
                         pincode          : Int,
                         security_code    : String,
                         emergencyname1   : String,
                         emergencymobile1 : String,
                         emergencyname    : String,
                         emergencymobile  : String,
                         mb_country_code  : String,
                         mb_country_code1 : String,
                         success : @escaping (_:String) -> Void,
                         failure : @escaping (_: String) -> Void) {

        let paramater: [String : Any] = [
            "name"                 : name,
            "mobile_country_code"  : mobile_country_code,
            "mobile"               : mobile,
            "password"             : password,
            "email"                : email,
            "gender"               : gender,
            "country_id"           : country_id,
            "state_id"             : state_id,
            "city_id"              : city_id,
            "district_id"          : district_id,
            "street"               : street,
            "pincode"              : pincode,
            "security_code"        : security_code,
            "emergencyname"        : emergencyname,
            "emergencymobile"      : emergencymobile,
            "emergencyname1"       : emergencyname1,
            "emergencymobile1"     : emergencymobile1,
            "mb_country_code"      : mb_country_code,
            "mb_country_code1"     : mb_country_code1,
            "term_And_condition"   : "true"
         ]
        
        Alamofire.request("\(WEB_API_URL)registeruser.php",
            method: .post,
            parameters: paramater,
            encoding: URLEncoding.default,
            headers: headers).responseJSON {
                
                response in
                print("\n\n\n Response =\(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let responseDict:[String:Any] = response.result.value as! [String : Any]
                    if responseDict[WEB_API_RESULT] as? String == WEB_API_SUCCESS {
                        let string = responseDict[WEB_API_STATUS] as! String
                        success(string)
                    }else{
                        let string = responseDict[WEB_API_RESULT] as? String
                        failure(string!)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
        }
        
    }
    
    
    
    // get country list
    func beSafeGetCountryList(with success : @escaping (_:[Country]) -> Void,
                                failure    : @escaping (_: String) -> Void){
        
        Alamofire.request("\(WEB_API_URL)getCountry.php",
            method: .post,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: headers).responseJSON {
                
                response in
                //print("Response = \(String(describing: response.result.value)))")
                if response.result.isSuccess {
                    let dictResponse :[String : AnyObject] = response.result.value as! [String : AnyObject]
                    if dictResponse[WEB_API_RESULT] as! String == WEB_API_SUCCESS {
                        let aryList = dictResponse[WEB_API_DATA] as! NSArray
                        var aryReson = [Country]()
                        let objResone = Country()
                        for index in 0..<aryList.count {
                            let obj = objResone.initWithCountrydict(aryList[index] as! [String : AnyObject])
                            aryReson.append(obj)
                        }
                        success(aryReson)
                    }else{
                        let error = dictResponse[WEB_API_STATUS] as! String
                        failure(error)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
        }
    }
    
    // get state list
    func beSafeGetStateList(with countryId:Int,
                            success : @escaping (_ :[State]) -> Void,
                            failure : @escaping (_: String) -> Void) {
        
        let paramater = ["id" : countryId]
        Alamofire.request("\(WEB_API_URL)getStates.php",
            method: .post,
            parameters: paramater,
            encoding: URLEncoding.default,
            headers: headers).responseJSON {
                
                response in
                //print("State = \(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let dictResponse : [String : AnyObject] = response.result.value as! [String : AnyObject]
                    if dictResponse[WEB_API_RESULT] as! String == WEB_API_SUCCESS {
                        
                        let aryList = dictResponse[WEB_API_DATA] as! NSArray
                        var aryState = [State]()
                        let objState = State()
                        for count in 0..<aryList.count {
                            let obj = objState.initWithStateName(aryList[count] as! [String : AnyObject])
                            aryState.append(obj)
                        }
                        success(aryState)
                    }else{
                        let error = dictResponse[WEB_API_STATUS] as! String
                        failure(error)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
        }
    }
    
    
    // get all distric / county
    func beSafeGetAllDistric(with stateId : Int,
                            success : @escaping(_:[District])->Void,
                            failure : @escaping(_:String)->Void) {
        
        let paramater : [String : Int] = ["id" : stateId]
        Alamofire.request("\(WEB_API_URL)getDistricts.php",
            method: .post,
            parameters: paramater,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
                
                response in
                //print("District = \(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let dictResponse : [String : AnyObject] = response.result.value as! [String : AnyObject]
                    if dictResponse[WEB_API_RESULT] as! String == WEB_API_SUCCESS {
                        let aryList = dictResponse[WEB_API_DATA] as! NSArray
                        var aryDistrict = [District]()
                        let objDistrict = District()
                        for count in 0..<aryList.count {
                            let obj = objDistrict.initWithDistrictName(aryList[count] as! [String : AnyObject])
                            aryDistrict.append(obj)
                        }
                        success(aryDistrict)
                    }else{
                        let error = dictResponse[WEB_API_STATUS] as! String
                        failure(error)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
            })
    }
    
    
    
    // get all city
    func beSafeAllGetCity(with stateId : Int,
                         success : @escaping(_:[City])->Void,
                         failure : @escaping(_:String)->Void) {
        
        let paramater : [String : Int] = ["id" : stateId]
        Alamofire.request("\(WEB_API_URL)getCities.php",
            method: .post,
            parameters: paramater,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
                
                response in
                //print("District = \(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let dictResponse : [String : AnyObject] = response.result.value as! [String : AnyObject]
                    if dictResponse[WEB_API_RESULT] as! String == WEB_API_SUCCESS {
                        
                        let aryList = dictResponse[WEB_API_DATA] as! NSArray
                        var aryCity = [City]()
                        let objCity = City()
                        for count in 0..<aryList.count {
                            let obj = objCity.initWithCityName(aryList[count] as! [String : AnyObject])
                            aryCity.append(obj)
                        }
                        success(aryCity)
                    }else{
                        let error = dictResponse[WEB_API_STATUS] as! String
                        failure(error)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
            })
    }
    
    // Home Button
    func sendDataUsingHealpButton(user_id Withuser_id : Int,
                                  sms_data : String,
                                  success  : @escaping(_: String) ->Void,
                                  failure  : @escaping(_: String) ->Void) {
        
        let parameter : [String: Any] = ["user_id"  : Withuser_id,
                                         "sms_data" : sms_data]
        
        Alamofire.request("\(WEB_API_URL)sos.php",
            method: .post,
            parameters: parameter,
            encoding: URLEncoding.default,
            headers: headers).responseJSON {
                
                response in
                    print("\n Response =\(String(describing: response.result.value))")
                    if response.result.isSuccess {
                        
                        let responseDict:[String:Any] = response.result.value as! [String : Any]
                        print("Success...........\(responseDict)")
                        if responseDict[WEB_API_RESULT] as! String == WEB_API_SUCCESS {
                            let successMessage = responseDict[WEB_API_STATUS] as! String
                            success(successMessage)
                        } else {
                            let error = responseDict[WEB_API_STATUS] as? String
                            failure(error!)
                        }
                    }
                    if response.result.isFailure {
                        failure((response.result.error?.localizedDescription)!)
                    }
        }
    }
    
    
    //left menu
    func changeEmergencyContact(_ user_id : Int,
                                success : @escaping(_:String)->Void,
                                failure : @escaping(_:String)->Void) {
        
        let parameter = ["user_id" : user_id]
        Alamofire.request("\(WEB_API_URL)UpdateEmergencyDetails.php",
            method: .post,
            parameters: parameter,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
                response in
                //print("\n Response =\(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let responseDict:[String:Any] = response.result.value as! [String : Any]
                    if responseDict[WEB_API_RESULT] as? String == WEB_API_SUCCESS {
                        success(responseDict[WEB_API_STATUS] as! String)
                    }else{
                        let string = responseDict[WEB_API_RESULT] as? String
                        success(string!)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
            })
    }
    
    // chnage user password 14)Url: http://eaccountantapp.com/testwomen/rest/updateSqurityCode.php
    func changeUserPassword(_ user_id : Int,
                            password : String,
                            success : @escaping(_:String)->Void,
                            failure : @escaping(_:String)->Void) {
        
        let param : [String : Any] = [
            "user_id"  : user_id,
            "password" :password
        ]
        Alamofire.request("\(WEB_API_URL)Update_Password.php",
            method: .post,
            parameters: param,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
                
                response in
                //print("Login Response = \(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let responseDict : [String : AnyObject] = response.result.value as! [String : AnyObject]
                    if responseDict[WEB_API_RESULT] as? String == WEB_API_SUCCESS {
                        
                        let message = responseDict[WEB_API_STATUS] as! String
                        success(message)
                    }
                    else
                    {
                        let error = responseDict[WEB_API_STATUS] as! String
                        failure(error)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
            })
    }

    func updateSecurityCode(user_id Withuser_id : Int,
                            success : @escaping(_:String)->Void,
                            failure : @escaping(_:String)->Void) {
        
        let parameter = ["user_id" : Withuser_id]
        
        Alamofire.request("\(WEB_API_URL)updateSqurityCode.php",
            method: .post,
            parameters: parameter,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
           
                response in
                print("\n Response =\(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let responseDict:[String:Any] = response.result.value as! [String : Any]
                    if responseDict[WEB_API_RESULT] as? String == WEB_API_SUCCESS {
                        success(responseDict[WEB_API_STATUS] as! String)
                    }else{
                        let string = responseDict[WEB_API_STATUS] as? String
                        failure(string!)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
            })
    }
    
    func updatePersonalInfo(user_id Withuser_id : Int,
                            success : @escaping(_:String)->Void,
                            failure : @escaping(_:String)->Void) {
        
        let parameter = ["user_id" : Withuser_id]
        
        Alamofire.request("\(WEB_API_URL)UpdatePersonalInfo.php",
            method: .post,
            parameters: parameter,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
                
                response in
                print("\n Response =\(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let responseDict:[String:Any] = response.result.value as! [String : Any]
                    if responseDict[WEB_API_RESULT] as? String == WEB_API_SUCCESS {
                        success(responseDict[WEB_API_STATUS] as! String)
                    }else{
                        let string = responseDict[WEB_API_STATUS] as? String
                        failure(string!)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
            })
    }
    // update user contact
    func updateUser(_ name              : String ,
                    mobile              : String,
                    email               : String,
                    gender              : String,
                    country_id          : Int,
                    state_id            : Int,
                    city_id             : Int,
                    district_id         : Int,
                    street              : String,
                    pincode             : String,
                    mobile_country_code : String,
                    user_id             : Int,
                    success : @escaping(_:User_Me)->Void,
                    failure : @escaping(_:String)->Void) {
        
        let dictParam : [String : Any] = [
            "name"                : name,
            "mobile"              : mobile,
            "email"               : email,
            "gender"              : gender,
            "country_id"          : country_id,
            "state_id"            : state_id,
            "city_id"             : city_id,
            "district_id"         : district_id,
            "street"              : street,
            "pincode"             : pincode,
            "mobile_country_code" : mobile_country_code,
            "user_id"             : user_id
        ]
        
        Alamofire.request("\(WEB_API_URL)UpdateUser.php",
            method: .post,
            parameters: dictParam,
            encoding: URLEncoding.default,
            headers: headers).responseJSON(completionHandler: {
                
                response in
                //print("Login Response = \(String(describing: response.result.value))")
                if response.result.isSuccess {
                    let responseDict : [String : AnyObject] = response.result.value as! [String : AnyObject]
                    if responseDict[WEB_API_RESULT] as? String == WEB_API_SUCCESS {
                        
                        let aryList : NSArray = responseDict[WEB_API_DATA] as! NSArray
                        
                        let objUser = User_Me()
                        var obj = User_Me()
                        for i in 0..<aryList.count {
                            obj = objUser.initWithUserdict(aryList[i] as! [String : AnyObject])
                        }
                        success(obj)
                    }
                    else
                    {
                        let error = responseDict[WEB_API_STATUS] as! String
                        failure(error)
                    }
                }
                if response.result.isFailure {
                    failure((response.result.error?.localizedDescription)!)
                }
            })
    }
    


    
    
}// class end
