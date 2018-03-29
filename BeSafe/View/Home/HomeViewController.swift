//
//  HomeViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 22/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    // MARK : - UIController
    @IBOutlet weak var btnCheck: UIButton!
    // left menu
    @IBOutlet weak var leadingConstrient: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var lbl_Name: UILabel!
    @IBOutlet weak var lbl_Contact: UILabel!
    
    var segue_Home_UpdateUser      = "segue_Home_UpdateUser"
    var segur_Home_UpdateContact   = "segur_Home_UpdateContact"
    var segue_Home_Help            = "segue_Home_Help"

    var menushowing = false
    var tocheckRememberMe : Bool = false
    
    var location_Manager : CLLocationManager?
    var lat : Double?
    var Lng : Double?
    var location_status : Bool = false
    var user_Address : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //left menu function
        self.hideLeftMenu()
        self.swapToDisplayLeftMenu()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.menushowing = false
        // grt Current Location 
        self.determineMyCurrentLocation()
        
        self.lbl_Name.text = GlobalDataServices.sharedInstance.user_Me.name
        self.lbl_Contact.text = GlobalDataServices.sharedInstance.user_Me.mobile
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // left
        if segue.identifier == segue_Home_UpdateUser {
            
        }
        if segue.identifier == segur_Home_UpdateContact {
            
        }
        if segue.identifier == segue_Home_Help {
            
        }
    }
 
/*
     Hey, I am in danger,need your help. My Address is Shanthi Complex, Jawaharlal Nehru Rd, Mangalwar Peth, Kasba Peth, Pune, Maharashtra 411011, India,Pune,Maharashtra,India and location :- http://maps.google.com/?q=18.522887,73.8673942  . My security code is - 2233. Please help me as soon as possible.
     
 
 */
    // function to get Address
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
        
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        //21.228124
        let lon: Double = Double("\(pdblLongitude)")!
        //72.833770
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler:
            {
                (placemarks, error) in
                if (error != nil)
                {
                    print("reverse geodcode fail: \(error!.localizedDescription)")
                }
                
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.country != nil {
                        addressString = addressString + pm.country! + ", "
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print(addressString)
                    
let strAddress = "I am in trouble, please help me. \n security pass code \(GlobalDataServices.sharedInstance.user_Me.security_code!).\n My contact no \(GlobalDataServices.sharedInstance.user_Me.mobile!) \n Address \(addressString) \n location http://maps.google.com/?q=\(self.lat!),\(self.Lng!) Please help me as soon as possible."
                    
                    print("help Address = \(strAddress)")
                    
                    
                    //PROGRESS_SHOW(view: self.view)
                    let user_id = GlobalDataServices.sharedInstance.user_Me.user_id!
  
                    Webservices.sharedInstance.sendDataUsingHealpButton(user_id: user_id,
                                                                        sms_data: strAddress,
                                                                        
                      success: {
                        
                         response in
                         PROGRESS_SUCCESS_HOME_MESSAGE(view: self.view, message: response)
                         //PROGRESS_HIDE()
                    },
                      failure: {
                        error in
                        PROGRESS_ERROR(view: self.view, error: error)
                    })
                }
        })
    }
    
    // MARK :- UIController Action
    @IBAction func btn_SOSClicked(_ sender: Any) {
        
        if self.location_status {
             self.getAddressFromLatLon(pdblLatitude: "\(self.lat!)", withLongitude: "\(self.Lng!)")
            /*  .......   // data send to polic or not
            if tocheckRememberMe {
                print("snd polic....")
            }
            else
            {
                print("not send polic....")
            } */
        }
        else
        {
           print(">>>>>>>>>>>>>>>>")
          self.determineMyCurrentLocation()
        }
    }
    
    @IBAction func btn_Selected(_ sender: Any) {
        if tocheckRememberMe {
            btnCheck.setImage(UIImage(named:"unselected"), for: .normal)
        }else {
            btnCheck.setImage(UIImage(named:"selected"), for: .normal)
        }
        tocheckRememberMe = !tocheckRememberMe
    }
    
    // left Menu
    @IBAction func btn_ShowLeft(_ sender: Any) {
        if menushowing {
            self.leftMenuHide()
        } else {
            self.leftMenuShow()
        }
    }
    
    @IBAction func btn_ChangePassword(_ sender: Any) {
        self.hideLeftMenu()
        self.performSegue(withIdentifier: segue_Home_UpdateUser, sender: self)
    }
    
    @IBAction func btn_ChangeEmergencyCont(_ sender: Any) {
        
        self.menushowing = !self.menushowing
         //self.performSegue(withIdentifier: segur_Home_UpdateContact, sender: self)
        let alert = UIAlertController(title: "BeSafe", message: "Are you sure, You want to change Emergency contact?", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {
            handler in

                PROGRESS_SHOW(view: self.view)
                let user_id = GlobalDataServices.sharedInstance.user_Me.user_id!
                Webservices.sharedInstance.changeEmergencyContact(user_id,
                                                              
                success: {
                    response in
                    PROGRESS_SUCCESS_MESSAGE(view: self.view, message: response)
                    PROGRESS_HIDE()
                    self.leftMenuHide()
                },
            
                failure: {
                    error in
                    PROGRESS_ERROR(view: self.view, error: error)
                })
            self.leftMenuHide()
        }))
        
        alert.addAction(UIAlertAction(title: "cancel", style: UIAlertActionStyle.cancel, handler: {
            handler in
            self.hideLeftMenu()
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

    @IBAction func btn_LogOutClicked(_ sender: Any) {
        
        let alertAction = UIAlertController(title: "BeSafe",
                                            message: "Are you sure, you want to logout?",
                                            preferredStyle: UIAlertControllerStyle.alert)
        
        alertAction.addAction(UIAlertAction(title: "Cancel",
                                            style: UIAlertActionStyle.cancel,
                                            handler: {
                                                handler in
                                                self.leftMenuHide()
                                                self.menushowing = !self.menushowing
        }))
        alertAction.addAction(UIAlertAction(title: "Ok",
                                            style: UIAlertActionStyle.default,
                                            handler: {
                                              handler in
                                                GlobalDataServices.sharedInstance.deleteUserinfo()
                                                self.dismiss(animated: true, completion: nil)
                                                
        }))
        self.present(alertAction, animated: true, completion: nil)
    }
}//end class


// MARK : - Function
extension HomeViewController {

    func determineMyCurrentLocation() {
        self.location_Manager = CLLocationManager()
        self.location_Manager?.delegate = self
        self.location_Manager?.desiredAccuracy = kCLLocationAccuracyBest
        self.location_Manager?.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.location_Manager?.startUpdatingLocation()
        }
    }
}







// MAEK : - Left Menu
extension HomeViewController {
    
    func hideLeftMenu() {
        
        menuView.layer.shadowOpacity = 1
        menuView.layer.shadowRadius = 10
        leadingConstrient.constant = -300
    }
    
    func leftMenuShow() {
        leadingConstrient.constant = 0
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
        menushowing = !menushowing
    }
    
    func leftMenuHide() {
        
        leadingConstrient.constant = -300
        UIView.animate(withDuration: 0.4, animations: {
            self.view.layoutIfNeeded()
        })
        menushowing = !menushowing
    }
    
    func swapToDisplayLeftMenu() {
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                self.leftMenuShow()
                
            case UISwipeGestureRecognizerDirection.left:
                self.leftMenuHide()
                
            default:
                break
            }
        }
    }
}






// MARK : - Datssources and delegate
extension HomeViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation : CLLocation = locations[0] as CLLocation
        // Assign Location to variable
        self.lat = userLocation.coordinate.latitude
        self.Lng = userLocation.coordinate.longitude
        // assign to label TEMP
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == CLAuthorizationStatus.denied {
            self.location_status = false
            self.showLocationDisablePopUp()
        } else {
            self.location_status = true
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error = \(error)")
    }
    
    // MARK : - Function
    func showLocationDisablePopUp() {
        
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "We need your location",
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Cancel",
                                                style: UIAlertActionStyle.cancel,
                                                handler: {
                                                    handler in
                                                    self.determineMyCurrentLocation()
        }))
        
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: UIAlertActionStyle.default,
                                                handler: {
                                                    handler in
                                                    if let url = URL(string: UIApplicationOpenSettingsURLString) {
                                                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                                    }
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
