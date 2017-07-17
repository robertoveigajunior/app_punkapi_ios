//
//  BeerTableViewController.swift
//  Roberto
//
//  Created by Roberto Luiz Veiga Junior on 15/07/17.
//  Copyright © 2017 robertoveigajunior. All rights reserved.
//

import UIKit

class BeerTableViewController: UITableViewController {

    var beers = [Beer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBeers()
    }
    
    func loadBeers() {
        Services().getBeer {
            self.beers = $0
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellBeer", for: indexPath)
        let item = beers[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "Teor: \(item.abv!)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = beers[indexPath.row]
        performSegue(withIdentifier: "sgDetail", sender: item)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgDetail" {
            
            let vc = segue.destination as! DetailViewController
            vc.beer = sender as! Beer
        }
    }
}
