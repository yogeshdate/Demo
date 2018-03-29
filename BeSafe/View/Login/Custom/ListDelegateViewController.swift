//
//  ListDelegateViewController.swift
//  BeSafe
//
//  Created by Yogesh Date on 27/02/18.
//  Copyright © 2018 Yogesh date. All rights reserved.
//

import UIKit

import UIKit

// protocol for Picker delegate
@objc protocol selectedListdelegate {
    func didSelectedList(indexpath : Int)
}

class ListDelegateViewController: UIViewController {
    
    //UIViewController
    @IBOutlet weak var lbl_Title: UILabel!
    @IBOutlet weak var pickerViewController: UIPickerView!
    //Variable
    public var aryName = [String]()
    var indexpath : Int?
    var listDelegate : selectedListdelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerViewController.dataSource = self
        self.pickerViewController.delegate = self
        self.pickerViewController.selectRow(0, inComponent: 0, animated: false)
        self.indexpath = 0
    }
    /*
     *
     *
     *
     *
     *
     *
     *
     *
     *
     *
     *
     *
     *
     */
    // MARK: - UIController Event
    @IBAction func btn_OkClick(_ sender: Any) {
        listDelegate?.didSelectedList(indexpath: self.indexpath!)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn_CancelClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}//end

/*
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 *
 */
// MARK: - DataSources and delegate
extension ListDelegateViewController:UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.aryName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.aryName[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.indexpath = row
    }
    
}
