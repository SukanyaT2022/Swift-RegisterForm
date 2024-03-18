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
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var memberImageView: UIImageView!
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    var memberName = ""
    var memberAddress = ""
    var memberPhone = ""
    var memberEmail = ""
    var memberData : Member?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //only text field or input box all we need delegate--protocal for component
        nameTextField.delegate = self
        addressTextField.delegate = self
        phoneTextField.delegate = self
        emailTextField.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //below one screen 2 function for second task if click user name so it go to register page and show all details
        if let memberData{
            //cnahge title register label to memeber detail
            titleLabel.text = "Member Details"
            nameTextField.text = memberData.name
           addressTextField.text = memberData.address
          phoneTextField.text = memberData.phone
            emailTextField.text = memberData.email
            if let phone = memberData.phone{
                getImage(imageName: phone)
                
            }
// we say weather user can chnage something or not but put false we we not allow
            nameTextField.isUserInteractionEnabled = false
            addressTextField.isUserInteractionEnabled = false
            phoneTextField.isUserInteractionEnabled = false
            emailTextField.isUserInteractionEnabled = false
            //below we hide submit button coz it's detail screen-hidden
            submitButton.isHidden = true
            //below we show delete button visibel
            deleteButton.isHidden = false
            
        }else{
//            for registration page need to show submit button
            submitButton.isHidden = false
            deleteButton.isHidden = true // hide delete button on register page
            
        }
    }

    @IBAction func submitButtonAction(_ sender: Any) {
        print(memberName)
        print(memberAddress)
        print(memberPhone)
        print(memberEmail)
        //if check if user fill all input box if one or all empty if not user can not click submit
        if memberName.isEmpty || memberAddress.isEmpty || memberEmail.isEmpty || memberPhone.isEmpty{
            showAlert(message: "Enter All Field")
            return
        }
        if let image = memberImageView.image{
            saveImage(imageName: memberPhone, image: image)
        }
        saveData()
    }
    //delete button from details page -register form page
    @IBAction func deleteButtonAction(_ sender: Any) {
        //below if we have member data if have value then give data from optional
        if let memberData, let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            //delete entity from core data
            appDelegate.persistentContainer.viewContext.delete(memberData)
            //after delete then save change
            appDelegate.saveContext()
            //after delete in register page then go back to memeber list page 
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func addPhotoButtonAction(_ sender: Any) {
        let actionSheet = UIAlertController(title: "Choose", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { action in
            self.openCamera(source: .camera)
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default) { action in
            self.openCamera(source: .photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style:.cancel)
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(galleryAction)
        actionSheet.addAction(cancelAction)
        self.present(actionSheet, animated: true)
    }
    //if user click cameara it open camera-if pick gallery and gallery open
    func openCamera(source: UIImagePickerController.SourceType){
      let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.delegate = self
        self.present(imagePicker, animated: true)
    }
    //continue write code open camera and gallery and display
    
    func showAlert(message:String){
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle:.alert)
        let okAction = UIAlertAction(title: "OK", style: .default)//create ok action if error message pop up
        alertController.addAction(okAction)//add action to alert
        self.present(alertController, animated:true)// display the box
    }
    //when we call saveImage func we use phone number to identify unique id
    //
    func saveImage(imageName:String,image:UIImage){
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(imageName)
        if FileManager.default.fileExists(atPath: fileURL.path) == false{
            try? image.pngData()?.write(to: fileURL)
            
        }
    }
    //function get image from the document--we not save on core such as name the file data but we save name in directory
    func getImage(imageName:String){
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent(imageName)
        if FileManager.default.fileExists(atPath: fileURL.path) == true{
            let image = UIImage(contentsOfFile: fileURL.path)
            memberImageView.image = image
            
        }
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
            
            //below pop up resister
            let alertController = UIAlertController(title: "", message: "Registered!", preferredStyle:.alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.clearScreen() //action ok to cler other text on screen
            }//create ok action if error message pop up to close popup register
            alertController.addAction(okAction)//add action to alert
            self.present(alertController, animated:true)// display the box
        }
    }
 
    
        //refresh screen sfter user type and data saved
    func clearScreen(){
        nameTextField.text = "" // connection
        addressTextField.text = ""
        phoneTextField.text = ""
        emailTextField.text = ""
        memberName = "" // empty variable
        memberAddress = ""
        memberPhone = ""
        memberEmail = ""
        memberImageView.image = nil
        
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

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //this function get image after user select
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            memberImageView.image = image
        }
    }
    //if user click cancel button above gallery
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

