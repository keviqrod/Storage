//
//  ChooseAccountTypeViewController.swift
//  Storage
//
//  Created by Ivy Nguyen on 8/24/21.
//

import UIKit
import FirebaseDatabase

class ChooseAccountTypeViewController: UIViewController {

    private let chooseHostOrUserPicker: ToolbarPickerView = ToolbarPickerView()
    private let choices = ["Host", "User"]
    let db = Database.database().reference()
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
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemOrange
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        setLayoutFrames()
        view.addSubview(pickerField)
        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(tappedNextButton), for: .touchUpInside)
    }
    
    private func setDelegates() {
        chooseHostOrUserPicker.dataSource = self
        chooseHostOrUserPicker.delegate = self
        chooseHostOrUserPicker.toolbarDelegate = self
        pickerField.inputView = chooseHostOrUserPicker
        pickerField.inputAccessoryView = self.chooseHostOrUserPicker.toolbar
    }
    
    private func setLayoutFrames() {
        pickerField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 52)
        nextButton.frame = CGRect(x: 20, y: 200, width: view.frame.size.width-4, height: 50)
    }
    
    @objc func tappedNextButton() {
        if pickerField.text == "User" {
            createNewUser()
        }
        else if pickerField.text == "Host" {
            createNewHost()
        }
        let vc = BasicRegistrationViewController()
        vc.title = "Basic Info"
        vc.modalPresentationStyle = .fullScreen
        vc.accountType = pickerField.text!
        present(UINavigationController(rootViewController: vc), animated: true)
    }
    
    private func createNewUser() {
        db.collection("users").add {
            err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
        }
    }
    
    private func createNewHost() {
        db.collection("hosts").add {
            err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                }
        }
    }
}

extension ChooseAccountTypeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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

extension ChooseAccountTypeViewController: ToolbarPickerViewDelegate {
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
