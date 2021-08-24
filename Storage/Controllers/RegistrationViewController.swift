//
//  RegistrationViewController.swift
//  Storage
//
//  Created by Student on 8/3/21.
//

import UIKit
import FirebaseFirestore

class RegistrationViewController: UIViewController {
    
    let database = Firestore.firestore()
    
    func writeUserData(name: String, dob: Date, email: String, password: String) {
        let docRef = database.document("User")
        docRef.setData(["name": name, "dob": dob, "email": email, "password": password])
    }
    
    func writeHostData(name: String, dob: Date, email: String, password: String) {
        let docRef = database.document("Host")
        docRef.setData(["name": name, "dob": dob, "email": email, "password": password])
    }
 
    
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
    
    let chooseHostOrUserPicker: ToolbarPickerView = ToolbarPickerView()
    let choices = ["Host", "User"]
    
    private let pickerField: UITextField = {
        let field = UITextField()
        field.placeholder = "Account Type"
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
    
    private let nameField: UITextField = {
        let field = UITextField()
        field.placeholder = "First and Last Names"
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
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerButton.addTarget(self, action: #selector(didTapRegister), for: .touchUpInside)
        
        chooseHostOrUserPicker.dataSource = self
        chooseHostOrUserPicker.delegate = self
        chooseHostOrUserPicker.toolbarDelegate = self
        pickerField.inputView = chooseHostOrUserPicker
        pickerField.inputAccessoryView = self.chooseHostOrUserPicker.toolbar
        nameField.delegate = self
        dobField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        confirmField.delegate = self
        
        view.addSubview(pickerField)
        view.addSubview(nameField)
        view.addSubview(dobField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(confirmField)
        view.addSubview(registerButton)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pickerField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 52)
        nameField.frame = CGRect(x: 20, y: pickerField.bottom + 10, width: view.width - 40, height: 52)
        dobField.frame = CGRect(x: 20, y: nameField.bottom + 10, width: view.width - 40, height: 52)
        emailField.frame = CGRect(x: 20, y: dobField.bottom + 10, width: view.width - 40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom + 10, width: view.width - 40, height: 52)
        confirmField.frame = CGRect(x: 20, y: passwordField.bottom + 10, width: view.width - 40, height: 52)
        registerButton.frame = CGRect(x: 20, y: confirmField.bottom + 10, width: view.width - 40, height: 52)
    }
    
    @objc private func didTapRegister() {
        pickerField.resignFirstResponder()
        nameField.resignFirstResponder()
        dobField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        confirmField.resignFirstResponder()
        
        guard let choice = pickerField.text, !choice.isEmpty,
              let name = nameField.text, !name.isEmpty,
              let dob = dobField.text, !dob.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
              let confirm = confirmField.text, !confirm.isEmpty, confirm == password else {
                return
        }
        if choice == "Host" {
            writeHostData(name: name, dob: dob, email: email, password: password)
        } else if choice == "User" {
            writeUserData(name: name, dob: dob, email: email, password: password)
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == pickerField {
            nameField.becomeFirstResponder()
        }
        else if textField == nameField {
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

extension RegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return choices.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return choices[row]
    }
}

extension RegistrationViewController: ToolbarPickerViewDelegate {

    func didTapDone() {
        let row = self.chooseHostOrUserPicker.selectedRow(inComponent: 0)
        self.chooseHostOrUserPicker.selectRow(row, inComponent: 0, animated: false)
        self.pickerField.text = self.choices[row]
        self.pickerField.resignFirstResponder()
    }
    func didTapCancel() {
        self.pickerField.text = nil
        self.pickerField.resignFirstResponder()
    }
}
