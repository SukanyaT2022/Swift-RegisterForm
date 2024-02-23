//
//  ViewController.swift
//  feb21SimplePage
//
//  Created by Tiparpron Sukanya on 2/21/24.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    var memberName = ""
    var memberAddress = ""
    var memberPhone = ""
    var memberEmail = ""
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
        print(memberName)
        print(memberAddress)
        print(memberPhone)
        print(memberEmail)
        saveData()
    }
    func saveData(){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let description = NSEntityDescription.entity(forEntityName: "Member", in:context)
            let memberEntity = NSManagedObject(entity: description!, insertInto: context) as? Member//! is force unwrap it can not be an option
            memberEntity?.name = memberName //.name is core data - right side name is variable
            memberEntity?.address = memberAddress
            memberEntity?.phone = memberPhone
            memberEntity?.email = memberEmail
            //below save everything on core data
            appDelegate.saveContext()
        }
    }
    func refreshScreen(){
        
    }
    func fetchMemberList(){
        
    }
}
extension ViewController: UITextFieldDelegate{
    //type shouldhange --enter -- what user type need store in variable
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField{
        case nameTextField:
           memberName = (textField.text ?? "") + string//if text not there so it consider empty --string from line44
        case addressTextField:
            memberAddress = (textField.text ?? "") + string
        case phoneTextField:
            memberPhone = (textField.text ?? "") + string
        case emailTextField:
           memberEmail = (textField.text ?? "") + string
        default:
            print()
        }
       return true
    }
    
}

