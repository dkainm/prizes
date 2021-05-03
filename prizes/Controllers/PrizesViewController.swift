//
//  ViewController.swift
//  prizes
//
//  Created by Alex Rudoi on 2/5/21.
//

import UIKit
import RealmSwift

class PrizesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    
    let realm = try! Realm()
    
    var prizes: Results<Prize>!
    var checkedCells: [UITableViewCell] = []
    
    var total = 0 {
        didSet {
            totalLabel.text = "Total: $\(total)"
            
            if total != 0 {
                UIView.transition(with: orderButton, duration: 0.5, options: .transitionCrossDissolve) {
                    self.orderButton.isHidden = false
                }
            } else {
                orderButton.isHidden = true
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func callDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func fetchData() {
        prizes = realm.objects(Prize.self)
        tableView.reloadData()
    }
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let newPrizeVC = storyboard!.instantiateViewController(withIdentifier: "NewPrizeViewController") as! NewPrizeViewController
        navigationController?.pushViewController(newPrizeVC, animated: true)
    }
    
}

extension PrizesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (prizes != nil) ? prizes.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prizeCell", for: indexPath)
        
        let prize = prizes[indexPath.row]
        
        cell.textLabel?.text = prize.name
        cell.detailTextLabel?.text = "$\(prize.price)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let prize = prizes[indexPath.row]
        
        if editingStyle == .delete {
            if tableView.cellForRow(at: indexPath)!.accessoryType == .checkmark {
                total -= prize.price
            }
            DatabaseManager.instance.deletePrize(prize)
        }
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        let price = prizes[indexPath.row].price
        
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
            total -= price
        } else {
            cell.accessoryType = .checkmark
            total += price
        }
        
        while total > 100 {
            for cell in tableView.visibleCells {
                
                let index = tableView.indexPath(for: cell)!.row
                
                if indexPath.row == index { continue }
                
                if cell.accessoryType == .checkmark {
                    cell.accessoryType = .none
                    total -= prizes[index].price
                    break
                }
            }
        }
    }
}

