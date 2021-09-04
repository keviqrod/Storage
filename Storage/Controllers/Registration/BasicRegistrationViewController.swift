//
//  BasicRegistrationViewController.swift
//  Storage
//
//  Created by Ivy Nguyen on 8/24/21.
//

import UIKit
import FirebaseFirestore

class BasicRegistrationViewController: UIViewController {

    private let chooseHostOrUserPicker: ToolbarPickerView = ToolbarPickerView()
    private let choices = ["Host", "User"]
    let db = Firestore.firestore()
        
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
        setDelegates()
        addSubviews()
        view.backgroundColor = .systemBackground
    }

    private func setDelegates() {
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
    }
    private func addSubviews() {
        view.addSubview(pickerField)
        view.addSubview(nameField)
        view.addSubview(dobField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(confirmField)
        view.addSubview(registerButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setLayoutFrames()
    }
    private func setLayoutFrames() {
        pickerField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 52)
        nameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 52)
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
        
        guard let accountType = pickerField.text, !accountType.isEmpty,
              let name = nameField.text, !name.isEmpty,
              let dob = dobField.text, !dob.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8,
              let confirm = confirmField.text, !confirm.isEmpty, confirm == password else {
                return
        }
        if accountType == "User" {
            createNewUser(name: name, dob: dob, email: email, password: password)
            let vc = YesOrNoViewController()
            vc.modalPresentationStyle = .fullScreen
            present(UINavigationController(rootViewController: vc), animated: true)
        }
        else if accountType == "Host" {
            createNewHost(name: name, dob: dob, email: email, password: password)
            let vc = HostQuestionsViewController()
            vc.modalPresentationStyle = .fullScreen
            present(UINavigationController(rootViewController: vc), animated: true)
        }
    }

    func createNewUser(name: String, dob: String, email: String, password: String) {
        db.collection("users").addDocument(data: ["name": name, "dob": dob, "email": email, "password": password]) {
            err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
        }
    }
    func createNewHost(name: String, dob: String, email: String, password: String) {
        db.collection("hosts").addDocument(data: ["name": name, "dob": dob, "email": email, "password": password]) {
            err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
        }
    }
}

extension BasicRegistrationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension BasicRegistrationViewController: ToolbarPickerViewDelegate {
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

extension BasicRegistrationViewController: UITextFieldDelegate {
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
