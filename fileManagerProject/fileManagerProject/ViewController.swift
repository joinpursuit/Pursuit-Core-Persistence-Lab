//
//  ViewController.swift
//  fileManagerProject
//
//  Created by Ahad Islam on 1/21/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var searchBar: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private var pix = [Pix]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //add searchbar delegation and make it do something.
    //add filemanagerhelper
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? DetailViewController {
            destVC.pix = pix[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    private func loadData() {
        
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pix.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photo cell", for: indexPath) as? PixTableViewCell else {
            return UITableViewCell()
        }
        cell.configurePixImage(pix[indexPath.row])
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
}
