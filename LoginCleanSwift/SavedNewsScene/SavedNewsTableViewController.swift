//
//  SavedNewsTableViewController.swift
//  LoginCleanSwift
//
//  Created by Владимир Юшков on 26.05.2022.
//

import UIKit

class SavedNewsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Saved news"
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { return UITableViewCell() }
        cell.newsTitleLabel.text = "Cell № \(indexPath.row)"
        return cell
    }
    
    
}
