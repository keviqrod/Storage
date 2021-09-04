//
//  YesOrNoViewController.swift
//  Storage
//
//  Created by Ivy Nguyen on 9/3/21.
//

import UIKit
import FirebaseFirestore

class YesOrNoViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var yesLabel: UIButton!
    @IBOutlet var noLabel: UIButton!
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    func setLabels() {
        questionLabel.text = "Do you have any new items to store?"
        yesLabel.setTitle("Yes", for: .normal)
        noLabel.setTitle("No", for: .normal)
    }
    
    @IBAction func didTapYes() {
        
        // create new collection & add storage objects to it
        // let accountID = db.collection("users").doc("ID").add()
        // accountID.setData([])
    }
    
    @IBAction func didTapNo() {
        let vc = HomeViewController()
        present(vc, animated: true)
    }

}
