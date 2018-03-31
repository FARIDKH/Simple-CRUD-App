//
//  NewPostViewController.swift
//  CRUD
//
//  Created by Farid Qanbarov on 3/31/18.
//  Copyright © 2018 Farid Qanbarov. All rights reserved.
//

import UIKit
import Firebase


class NewPostViewController: UIViewController {

    @IBOutlet weak var newPostTextField: UITextField!
    let databaseRef = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addPost() {
        if let newPost = newPostTextField.text {
            guard let id = uid else {
                return
            }
            databaseRef.child("users").child(id).setValuesForKeys(["post":newPost])
            
        }
    }
    
    @IBAction func addNewPost(_ sender: UIButton) {
        addPost()
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
