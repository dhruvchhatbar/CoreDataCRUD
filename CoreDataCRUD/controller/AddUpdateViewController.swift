//
//  AddViewController.swift
//  CoreDataCRUD
//
//  Created by Dhruv Chhatbar on 13/01/24.
//

import UIKit

class AddUpdateViewController: UIViewController {

    @IBOutlet var tfUsername: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfEmail: UITextField!
    @IBOutlet var tfUpdateEmail: UITextField!
    @IBOutlet var vwUpdate: UIView!
    @IBOutlet var lblError: UILabel!
    @IBOutlet var btnUpdate: UIButton!
    
    @IBOutlet var btnSubmit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = StringConstants.primaryColor
        btnSubmit.tintColor = StringConstants.primaryColor
        btnUpdate.titleLabel?.numberOfLines = 0
    }
    private func validate() -> Bool{
        var valid = true
        if tfUsername.text?.count ?? 0 < 0 || !((tfUsername.text?.contains(where: {($0.isWhitespace)})) != nil){
            lblError.text = "Error \n Invalid Username"
            valid = false
        }
        else if tfPassword.text?.isEmpty ?? false{
            lblError.text = "Error \n Invalid Password"
            valid = false
        }
        else if tfEmail.text?.isEmpty ?? false{
            lblError.text = "Error \n Invalid Email"
            valid = false
        }
        return valid
        
    }
    private func validateUpdate() -> Bool{
        var valid = true
        if tfUsername.text?.count ?? 0 < 0 || !((tfUsername.text?.contains(where: {($0.isWhitespace)})) != nil){
            lblError.text = "Error \n Invalid Username"
            valid = false
        }
        else if tfPassword.text?.isEmpty ?? false{
            lblError.text = "Error \n Invalid Password"
            valid = false
        }
        else if tfEmail.text?.isEmpty ?? false{
            lblError.text = "Error \n Invalid Email"
            valid = false
        }
        else if tfUpdateEmail.text?.isEmpty ?? false{
            lblError.text = "Error \n Invalid Update Email"
            valid = false
        }
        return valid
        
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        if vwUpdate.isHidden{
            if validate(){
                CoreDataSingleton.shared.createCoreData(username: tfUsername.text!, password: tfPassword.text!, email: tfEmail.text!){
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        else{
            if validateUpdate(){
                CoreDataSingleton.shared.updateUserData(username: tfUsername.text!, password: tfPassword.text!, email: tfEmail.text!, updatingEmail: tfUpdateEmail.text!){
                    navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
    @IBAction func btnUpdatePressed(_ sender: UIButton) {
        if sender.tag == 0{
            sender.tag = 1
            btnUpdate.imageView?.image = UIImage(named: "")
            btnUpdate.setTitle("Write your email which you want to update", for: .normal)
            vwUpdate.isHidden = false
            btnSubmit.setTitle("Update User", for: .normal)
        }
        else{
            sender.tag = 0
            btnUpdate.setImage(UIImage(systemName: "checkmark.rectangle.portrait"), for: .normal)
            btnUpdate.setTitle("Update user?", for: .normal)
            vwUpdate.isHidden = true
            btnSubmit.setTitle("Add User", for: .normal)
        }
    }
    
}
