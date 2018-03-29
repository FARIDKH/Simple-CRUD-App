//
//  LoginViewController.swift
//  CRUD
//
//  Created by Farid Qanbarov on 3/29/18.
//  Copyright © 2018 Farid Qanbarov. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleLogin() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {
                return
        }
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                print(error)
            }
            SVProgressHUD.dismiss()
            self.performSegue(withIdentifier: "gotoTableViewFromLogin", sender: self)
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        SVProgressHUD.show()
        handleLogin()
        return true
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        SVProgressHUD.show()
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        handleLogin()
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
