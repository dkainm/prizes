//
//  NewPrizeViewController.swift
//  prizes
//
//  Created by Alex Rudoi on 2/5/21.
//

import UIKit

class NewPrizeViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func acceptTapped(_ sender: UIButton) {
        guard let name = nameTF.text else { return }
        guard let price = Int(priceTF.text!) else { return }
        
        DatabaseManager.instance.addPrize(Prize(name: name, price: price))
        navigationController?.popViewController(animated: true)
    }
}
