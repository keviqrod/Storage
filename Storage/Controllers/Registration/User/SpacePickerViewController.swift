//
//  SpacePickerViewController.swift
//  Storage
//
//  Created by Ivy Nguyen on 9/3/21.
//

import UIKit
import FirebaseFirestore

class SpacePickerViewController: UIViewController {

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var fiveByFiveLabel: UIButton!
    @IBOutlet var fiveByTenLabel: UIButton!
    @IBOutlet var tenByTenLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    func setLabels() {
        questionLabel.text = "How much space do you need?"
        fiveByFiveLabel.setTitle("5' by 5'", for: .normal)
        fiveByTenLabel.setTitle("5' by 10'", for: .normal)
        tenByTenLabel.setTitle("10 by 10", for: .normal)
    }
    
    @IBAction func didPressFiveByFive() {
        
    }
    
    @IBAction func didPressFiveByTen() {
        
    }
    
    @IBAction func didPressTenByTen() {
        
    }

}
