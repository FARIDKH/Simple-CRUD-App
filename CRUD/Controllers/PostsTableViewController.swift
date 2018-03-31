//
//  PostsTableViewController.swift
//  CRUD
//
//  Created by Farid Qanbarov on 3/29/18.
//  Copyright © 2018 Farid Qanbarov. All rights reserved.
//

import UIKit
import Firebase
import SwiftyJSON

class PostsTableViewController: UITableViewController {

    var users : [User] = [User]()
    let cellId = "Post Cells"
    
    let databaseRef = Database.database().reference(fromURL: "https://crud-app-3232b.firebaseio.com/")
    let userId = Auth.auth().currentUser?.uid
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: cellId)
        databaseRef.child("users").observe(.childAdded, with: { (snapshot) in
            if let userInfos = snapshot.value as? [String : AnyObject] {

                let user = User()
                user.email = userInfos["email"] as? String
                user.pictureURL = userInfos["pictureURL"]  as? String
                user.username = userInfos["username"]  as? String
                
                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }



        }, withCancel: nil)
//
//        databaseRef.child("users").observeSingleEvent(of: .value) { (snapshot) in
//            let snapValue = snapshot.value!
//            let userDatas = JSON(snapValue)
//            self.parseJSON(json: userDatas)
//        }
    }

    // MARK: Parsing JSON
//
//    func parseJSON(json: JSON) {
//        json.forEach { (string,json) in
//            let email = json["email"].stringValue
//            let username = json["username"].stringValue
//            let pictureURL = json["pictureURL"].stringValue
//
//            let user = User()
//            user.email = email
//            user.pictureURL = pictureURL
//            user.username = username
//            users.append(user)
//            self.tableView.reloadData()
//        }
//    }
//
    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            cell.textLabel?.text = users[indexPath.row].username
            if let pictureURL = users[indexPath.row].pictureURL {
                let storageRef = Storage.storage().reference(forURL: pictureURL)
                storageRef.getData(maxSize: 100 * 1024 * 1024) { (data, error) in
                    if error != nil {
                        print(error)
                        return
                    }
                    if let imageData = data {
                        DispatchQueue.main.async {
                            cell.imageView?.image = UIImage(data: imageData)
                            cell.setNeedsLayout()
                            cell.layoutIfNeeded()
                            tableView.estimatedRowHeight = 100.0
                            tableView.rowHeight = UITableViewAutomaticDimension
                        }

                    }

                }
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

