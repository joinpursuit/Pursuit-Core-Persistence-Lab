//
//  FavoritesViewController.swift
//  fileManagerProject
//
//  Created by Ahad Islam on 1/27/20.
//  Copyright © 2020 Ahad Islam. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var pix = [Pix]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? DetailViewController {
            destVC.pix = pix[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    private func loadData() {
        do {
            pix = try PixPersistenceHelper.manager.getPix()
        } catch {
            let alertVC = UIAlertController(title: "Error", message: "Unable to get favorites: \(error)", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pix.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photo cell", for: indexPath) as? PixTableViewCell else {
            fatalError("Cell could not be formed as PixTableViewCell")
        }
        cell.configurePixImage(pix[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
}

