//
//  UpdateContactViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 23/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

class UpdateContactViewController: UIViewController {

    // MARK : - UIController
    @IBOutlet weak var text_Person1: UITextField!
    @IBOutlet weak var text_MobileNo: UITextField!
    @IBOutlet weak var text_Person2: UITextField!
    @IBOutlet weak var text_mobile2: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func btn_Submit(_ sender: Any) {
//        if self.validaton() {
//            print("Done................")
//        }
    }
}



// MARK : - Function
extension UpdateContactViewController {
    
    func validaton() -> Bool {
        
        if self.text_Person1.text == "" {
            self.showAlertController("Enter person 1")
            return false
        }
        if self.text_MobileNo.text == "" {
            self.showAlertController("Enter Mobile ")
            return false
        }
        if self.text_Person2.text == "" {
            self.showAlertController("Enter person 2")
            return false
        }
        if self.text_mobile2.text == "" {
            self.showAlertController("Enter Mobile ")
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

