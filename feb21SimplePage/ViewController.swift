//
//  ViewController.swift
//  feb21SimplePage
//
//  Created by Tiparpron Sukanya on 2/21/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var name = ""
    var address = ""
    var phone = ""
    var email = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //only text field or input box all we need delegate--protocal for component
        nameTextField.delegate = self
        addressTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        
    }

    @IBAction func submitButtonAction(_ sender: Any) {
        print(name)
        print(address)
        print(phone)
        print(email)
    }
    
}
extension ViewController: UITextFieldDelegate{
    //type shouldhange --enter -- what user type need store in variable
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField{
        case nameTextField:
            name = (textField.text ?? "") + string//if text not there so it consider empty --string from line44
        case addressTextField:
            address = (textField.text ?? "") + string
        case phoneTextField:
            phone = (textField.text ?? "") + string
        case emailTextField:
           email = (textField.text ?? "") + string
        default:
            print()
        }
       return true
    }
    
}

