//
//  PersonalInformationViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 23/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import NKVPhonePicker

class PersonalInformationViewController: UIViewController {

    @IBOutlet weak var text_Fname: UITextField!
    @IBOutlet weak var text_CountryCode: NKVPhonePickerTextField!
    @IBOutlet weak var text_MobileNo: UITextField!
    @IBOutlet weak var text_EmailId: UITextField!
    @IBOutlet weak var text_Country: UITextField!
    @IBOutlet weak var text_State: UITextField!
    @IBOutlet weak var text_County: UITextField!
    @IBOutlet weak var text_City: UITextField!
    @IBOutlet weak var text_Area: UITextField!
    @IBOutlet weak var text_PinCode: UITextField!
    
    // MARK : - Variable and object
    var objCountry = Country()
    var objState   = State()
    var objDict    = District()
    var objCity    = City()
    
    var selectedDelegate = ""
    var aryCountry = [Country]()
    var aryState   = [State]()
    var aryDistric = [District]()
    var aryCity    = [City]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //get data to left vc
        self.text_Fname.text = GlobalDataServices.sharedInstance.user_Me.name
        self.text_EmailId.text = GlobalDataServices.sharedInstance.user_Me.email
        self.text_MobileNo.text = GlobalDataServices.sharedInstance.user_Me.mobile
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "segue_personalinfo_Country"{
            let country = segue.destination as! ListDelegateViewController
            //self.aryCountry.removeAll()
            for i in 0..<aryCountry.count {
                let cnt = self.aryCountry[i]
                country.aryName.append(cnt.countryName!)
            }
            country.listDelegate = self
        }
        
        if segue.identifier == "segue_personalInfo_State" {
            let state = segue.destination as! ListDelegateViewController
            for i in 0..<aryState.count {
                let obj = self.aryState[i]
                state.aryName.append(obj.state_name!)
            }
            state.listDelegate = self
        }
        
        if segue.identifier == "segue_personalInfo_county" {
            let county = segue.destination as! ListDelegateViewController
            for i in 0..<self.aryDistric.count {
                let obj = self.aryDistric[i]
                county.aryName.append(obj.districtName!)
            }
            county.listDelegate = self
        }
        
        if segue.identifier == "segue_personal_city" {
            let county = segue.destination as! ListDelegateViewController
            for i in 0..<self.aryCity.count {
                let obj = self.aryCity[i]
                county.aryName.append(obj.city_name!)
            }
            county.listDelegate = self
        }
    }

    
    
    
    
    // MARK : - UICOntroller
    @IBAction func btn_Country(_ sender: UIButton) {
        
        self.text_State.text = ""
        self.text_County.text = ""
        self.text_City.text = ""
        self.selectedDelegate = "Country"
        PROGRESS_SHOW(view: self.view)
        self.aryCountry.removeAll()
        Webservices.sharedInstance.beSafeGetCountryList(with: {
            
            aryResponse in
            for i in 0..<aryResponse.count {
                let obj : Country = aryResponse[i]
                self.aryCountry.append(obj)
            }
            PROGRESS_HIDE()
            self.performSegue(withIdentifier: "segue_personalinfo_Country" , sender: self)
        })
        {
            error in
            PROGRESS_ERROR(view: self.view, error: error)
        }
        
    }
  
    @IBAction func btn_State(_ sender: UIButton) {
        
        if text_Country.text == "" {
            self.showAlertController("Select Country")
        }else{
            self.text_County.text = ""
            self.text_City.text = ""
            self.selectedDelegate = "State"
            self.aryState.removeAll()
            PROGRESS_SHOW(view: self.view)
            Webservices.sharedInstance.beSafeGetStateList(with: self.objCountry.country_id!,
                                                          
            success: {
                aryResponse in
                PROGRESS_HIDE()
                for i in 0..<aryResponse.count {
                    let obj : State = aryResponse[i]
                    self.aryState.append(obj)
                }
                PROGRESS_HIDE()
                self.performSegue(withIdentifier: "segue_personalInfo_State" , sender: self)
            },
            
            failure: {
                error in
                PROGRESS_ERROR(view: self.view, error: error)
            })
        }
    }
    
    @IBAction func btn_County(_ sender: UIButton) {
        
        if text_State.text == "" {
            self.showAlertController("Select State")
        }else{

            self.text_City.text = ""
            self.selectedDelegate = "County"
            self.aryDistric.removeAll()
            PROGRESS_SHOW(view: self.view)
            Webservices.sharedInstance.beSafeGetAllDistric(with: self.objState.state_id!,
               success: {
                
                    responseAray in
                    PROGRESS_HIDE()
                    for i in 0..<responseAray.count {
                        let obj : District = responseAray[i]
                        self.aryDistric.append(obj)
                    }
                    PROGRESS_HIDE()
                    self.performSegue(withIdentifier: "segue_personalInfo_county" , sender: self)
            },
        
            failure: {
                
                 error in
                 PROGRESS_ERROR(view: self.view, error: error)
            })
        }
    }
    
    @IBAction func btn_City(_ sender: UIButton) {
        
        if text_County.text == "" {
            self.showAlertController("Select County")
        }else{
            self.selectedDelegate = "City"
            self.aryDistric.removeAll()
            PROGRESS_SHOW(view: self.view)
            Webservices.sharedInstance.beSafeAllGetCity(with: self.objDict.district_id!,
              success: {
                
                responseAray in
                PROGRESS_HIDE()
                for i in 0..<responseAray.count {
                    let obj : City = responseAray[i]
                    self.aryCity.append(obj)
                }
                PROGRESS_HIDE()
                self.performSegue(withIdentifier: "segue_personal_city" , sender: self)
                    
            },
              failure: {
                error in
                PROGRESS_ERROR(view: self.view, error: error)
            })
        }
    }
    
    
    @IBAction func text_Submit(_ sender: UIButton) {
        
        if self.validaton(){
            let country = self.text_CountryCode.text!
            let phoneCode = country.replacingOccurrences(of: "+", with: "", options: NSString.CompareOptions.literal, range:nil)
            
            PROGRESS_SHOW(view: self.view)
            Webservices.sharedInstance.updateUser(self.text_Fname.text!,
                                                  mobile: self.text_MobileNo.text!,
                                                  email: self.text_EmailId.text!,
                                                  gender: "",
                                                  country_id: self.objCountry.country_id!,
                                                  state_id: self.objState.state_id!,
                                                  city_id: self.objCity.id!,
                                                  district_id: self.objDict.district_id!,
                                                  street: self.text_Area.text!,
                                                  pincode: self.text_PinCode.text!,
                                                  mobile_country_code: phoneCode,
                                                  user_id: GlobalDataServices.sharedInstance.user_Me.user_id!,
               success: {
                
                 response in
                 GlobalDataServices.sharedInstance.deleteUserinfo()
                 GlobalDataServices.sharedInstance.insertNewUser(user: response)
                 PROGRESS_SUCCESS_MESSAGE(view: self.view, message: "Update successfully")
                 PROGRESS_HIDE()
                
            },
            failure: {
                
              error in
              PROGRESS_ERROR(view: self.view, error: error)
                
            })
            
        }
    }
}


// MARK : - Function
extension PersonalInformationViewController {
    
    func validaton() -> Bool {
        
        if self.text_Fname.text == "" {
            self.showAlertController("Enter name")
            return false
        }
        if self.text_MobileNo.text == "" {
            self.showAlertController("Enter mobile no")
            return false
        }
        if self.text_EmailId.text == "" {
            self.showAlertController("Enter email id")
            return false
        }
        if self.text_Country.text == "" {
            self.showAlertController("Enter country")
            return false
        }
        if self.text_State.text == "" {
            self.showAlertController("Enter state")
            return false
        }
        if self.text_County.text == "" {
            self.showAlertController("Enter county")
            return false
        }
        if self.text_City.text == "" {
            self.showAlertController("Enter city")
            return false
        }
        if self.text_Area.text == "" {
            self.showAlertController("Enter area")
            return false
        }
        if self.text_PinCode.text == "" {
            self.showAlertController("Enter pincode")
            return false
        }
        return true
    }
    
    func showAlertController(_ messag: String) {
        
        let alert = UIAlertController(title: "BeSafe", message: messag, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
            action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}



extension PersonalInformationViewController : selectedListdelegate {
    
    func didSelectedList(indexpath: Int) {
        
        if self.selectedDelegate == "Country" {
            self.selectedDelegate = ""
            self.objCountry = self.aryCountry[indexpath]
            self.text_Country.text = self.objCountry.countryName!
            print("\n\n IndexPath = \(self.objCountry.countryName!)")
        }
        
        if self.selectedDelegate == "State" {
            self.selectedDelegate = ""
            self.objState = self.aryState[indexpath]
            self.text_State.text = self.objState.state_name!
            print("\n\n IndexPath = \(self.objState.state_name!)")
        }
        
        if self.selectedDelegate == "County" {
            self.selectedDelegate = ""
            self.objDict = self.aryDistric[indexpath]
            self.text_County.text = self.objDict.districtName!
            print("\n\n indexpath = \(self.objDict.districtName!)")
        }
        
        if self.selectedDelegate == "City" {
            self.selectedDelegate = ""
            self.objCity = self.aryCity[indexpath]
            self.text_City.text = self.objCity.city_name
            print("\n\n indexpath = \(self.objCity.id!)")
        }
    }
}

