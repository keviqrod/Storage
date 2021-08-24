//
//  UserQuestionsViewController.swift
//  Storage
//
//  Created by Ivy Nguyen on 8/23/21.
//

import UIKit

class UserQuestionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableview = UITableView()
    
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
