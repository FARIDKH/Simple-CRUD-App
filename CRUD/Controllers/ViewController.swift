//
//  ViewController.swift
//  CRUD
//
//  Created by Farid Qanbarov on 3/26/18.
//  Copyright © 2018 Farid Qanbarov. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonIsTapped(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            performSegue(withIdentifier: "goToRegister", sender: self)
        case 2:
            performSegue(withIdentifier: "goToLogin", sender: self)
        default:
            break;
        }
        
    }
    
}

