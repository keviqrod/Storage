//
//  ViewController.swift
//  Storage
//
//  Created by Student on 8/3/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // Call authentification function here
        
        // Check auth status --to check if previous account or empty--to be edited later
        // Should create a special function for following code when backend
        //   if user not logged in already, do following
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        present(loginVC, animated: false)
        
        //   else load normal screen
        
   
        
    }


}

