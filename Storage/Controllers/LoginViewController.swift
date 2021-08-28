//
//  LoginViewController.swift
//  Storage
//
//  Created by Student on 8/3/21.
//

import UIKit
import SafariServices
import Foundation
import FirebaseAuth
import Dispatch

class LoginViewController: UIViewController {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    
    // Want to eventually verify that this is somehow a school email address somehow
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Password"
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("Create account here!", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "icon-76"))
        header.addSubview(backgroundImageView)
//        header.backgroundColor = .red
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        usernameEmailField.delegate = self
        passwordField.delegate = self
        addSubviews()
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // assign frames when function called
        
        // may need to adjust as well
        headerView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 50, width: view.width,
                                  height: view.height/3.0)
        
        usernameEmailField.frame = CGRect(x: 25, y: headerView.bottom + 10, width: view.width - 50,
                                          height: 52.0)
        
        passwordField.frame = CGRect(x: 25, y: usernameEmailField.bottom + 10, width: view.width - 50,
                                          height: 52.0)
        
        loginButton.frame = CGRect(x: 25, y: passwordField.bottom + 10, width: view.width - 50,
                                          height: 52.0)
        
        createAccountButton.frame = CGRect(x: 25, y: loginButton.bottom + 10, width: view.width - 50,
                                          height: 52.0)
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        // add logo!!
//        let textView = UIImageView(image: UIImage(named: "Image"))
//        headerView.addSubview(textView)
//        textView.contentMode = .scaleAspectFit
//        // need to adjust constants below for y and height
//        textView.frame = CGRect(x: headerView.width/4.0, y: view.safeAreaInsets.top + 220, width: headerView.width/2.0, height: headerView.height - view.safeAreaInsets.top - 100)
    }
    
    private func addSubviews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginButton() {
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        // Email + Password check if valid
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                return
        }
        // log in
        var email: String?
        if usernameEmail.contains("@"), usernameEmail.contains(".edu"){
            email = usernameEmail
        }
        else if usernameEmail.contains("@"), usernameEmail.contains(".edu") {
            email = usernameEmail
        }
        else {
            
        }

        authoManager.shared.loginNewUser(email: email, password: password) {
            success in
            DispatchQueue.main.async {
                if success {
                    // user logged in
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Log In Error", message: "We were not able to log you in :(", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    @objc public func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "Create a new account"
        vc.modalPresentationStyle = .fullScreen
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }
        
        else if textField == passwordField {
            didTapLoginButton()
        }
        
        return true
    }
}
