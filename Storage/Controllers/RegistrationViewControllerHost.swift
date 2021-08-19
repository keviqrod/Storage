//
//  RegistrationViewControllerHost.swift
//  Storage
//
//  Created by Kevin Rodriguez on 8/15/21.
//

import UIKit

class RegistrationViewControllerHost: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    struct Constants {
        static let cornerRadius: CGFloat = 8.0
    }
    // need to add feature here that rejects emails if they are not valid and/or affiliated with university
    // also in general, could use something that ensures "return" take susers to each subsequent bar
    var currentImage: UIImage!
    
    // somehow get system to save this photo for use later + also display it while signing up
//    func imagePickerController(_ picker: UIImage, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//        guard let image = info[.editedImage] as? UIImage else { return }
//
//        dismiss(animated: true)
//
//        currentImage = image
//    }
//
//    @objc func importPicture() {
//        let picker = UIImagePickerController()
//        picker.allowsEditing = true
//        picker.delegate = self
//        present(picker, animated: true)
//    }
    
    private let nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "First and Last Names"
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let dobField: UITextField = {
        let field = UITextField()
        field.placeholder = "DOB (mm/dd/yyyy)"
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
    
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email Address (must end in .edu!)"
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
    
    private let confirmField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "Confirm Password"
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
//    private let profileButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.layer.cornerRadius = 15
//        button.clipsToBounds = true
//        button.setImage(UIImage(named: "generic"), for: .normal)
//        button.imageView?.contentMode = .scaleAspectFit
//        return button
//
//    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Become a host with us!"
        
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
//        profileButton.addTarget(self, action: #selector(importPicture), for: .touchUpInside)
        
        nameField.delegate = self
        dobField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmField.delegate = self
        
//        view.addSubview(profileButton)
        view.addSubview(nameField)
        view.addSubview(dobField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(confirmField)
        view.addSubview(registerButton)
        
        
        view.backgroundColor = .systemBackground

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 52)
//        profileButton.frame = CGRect(x: 20 + nameField.right, y: view.safeAreaInsets.top + 10, width: 30, height: 30)
        dobField.frame = CGRect(x: 20, y: nameField.bottom + 10, width: view.width - 40, height: 52)
        emailField.frame = CGRect(x: 20, y: dobField.bottom + 10, width: view.width - 40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width - 40, height: 52)
        confirmField.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width - 40, height: 52)
        registerButton.frame = CGRect(x: 20, y: confirmField.bottom + 10, width: view.width - 40, height: 52)

    }
    
    @objc private func didTapRegister() {
        nameField.resignFirstResponder()
        dobField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmField.resignFirstResponder()
        
        guard let name = nameField.text, !name.isEmpty,
              let dob = dobField.text, !dob.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
              let confirm = confirmField.text, !confirm.isEmpty, confirm == password else {
                return
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegistrationViewControllerHost: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == nameField {
            dobField.becomeFirstResponder()
        }
        else if textField == dobField {
            emailField.becomeFirstResponder()
        }
        
        else if textField == passwordField {
            confirmField.becomeFirstResponder()
        }
        
        else {
            didTapRegister()
        }
        return true
    }
}
