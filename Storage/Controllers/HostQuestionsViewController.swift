//
//  HostQuestionsViewController.swift
//  Storage
//
//  Created by Ivy Nguyen on 8/23/21.
//

import UIKit

class HostQuestionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let tableview = UITableView()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableview)
        tableview.register(UITableView.self, forCellReuseIdentifier: "cell")
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableview.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }

}
