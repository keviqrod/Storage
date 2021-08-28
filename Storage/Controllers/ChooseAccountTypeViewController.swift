//
//  ChooseAccountTypeViewController.swift
//  Storage
//
//  Created by Ivy Nguyen on 8/24/21.
//

import UIKit

class ChooseAccountTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        chooseHostOrUserPicker.dataSource = self
        chooseHostOrUserPicker.delegate = self
        chooseHostOrUserPicker.toolbarDelegate = self
        pickerField.inputView = chooseHostOrUserPicker
        pickerField.inputAccessoryView = self.chooseHostOrUserPicker.toolbar
        view.addSubview(pickerField)
        pickerField.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 10, width: view.width - 40, height: 52)
    }
    
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
