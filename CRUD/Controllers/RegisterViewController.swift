//
//  RegisterViewController.swift
//  CRUD
//
//  Created by Farid Qanbarov on 3/26/18.
//  Copyright © 2018 Farid Qanbarov. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
        
    
    let uid = Auth.auth().currentUser?.uid
    let imagePicker = UIImagePickerController()
    let storage = Storage.storage(url: "gs://crud-app-3232b.appspot.com/")
    let databaseRef = Database.database().reference(fromURL: "https://crud-app-3232b.firebaseio.com/")
    var resultChecking = false
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(profileImageSelectHandler)))
        // Do any additional setup after loading the view.
        
    }
    @IBAction func registerButtonTapped(_ sender: UIButton) {

        SVProgressHUD.show()
        handleRegister()
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func handleRegister() {
        
        guard let email = emailTextField.text,
            let username = usernameTextField.text else {
            return
        }
        if let imageData = UIImagePNGRepresentation(profileImageView.image!) {
            let imageName = NSUUID().uuidString
            let storageRef = storage.reference().child("\(imageName)")
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error)
                } else {
                    if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                        let userDatas = [
                            "username" : username,
                            "email": email,
                            "pictureURL": profileImageURL,
                            "post" : ""
                        ]
                        self.registeringUser(values: userDatas as [String : AnyObject])
                    }
                }
            }
        }
    }
    
    @objc func profileImageSelectHandler() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        profileImageView.image = pickedImage
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func registeringUser(values : [String : AnyObject]) {
        if let email = emailTextField.text ,
            let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                
                guard let id = self.uid else {
                    return
                }
                let usersReference = self.databaseRef.child("users").child(id)
                usersReference.updateChildValues(values, withCompletionBlock: { (error, reference) in
                    if error != nil {
                        print(error)
                        return
                    }
                })
                if error != nil {
                    print(error)
                } else {
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "gotoTableViewFromRegister", sender: self)
                }
            })
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
