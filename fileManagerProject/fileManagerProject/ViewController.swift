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
    private var searchQuery: String? = nil
    
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
        let endpoint = "https://pixabay.com/api/?key=\(AppKey.appKey)&q=" + (searchQuery ?? "")
        
        GenericCoderAPI.manager.getJSON(objectType: PixWrapper.self, with: endpoint) { result in
            switch result {
            case .failure(let error):
                print("Error occurred getting JSON: \(error)")
            case .success(let wrapper):
                self.pix = wrapper.hits
            }
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pix.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photo cell", for: indexPath) as? PixTableViewCell else {
            fatalError("Cell could not be formed as PixTableViewCell")
        }
        cell.configurePixImage(pix[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resignFirstResponder()
        searchQuery = searchBar.text?.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        loadData()
    }
    
}
