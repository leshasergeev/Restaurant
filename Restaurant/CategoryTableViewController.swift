//
//  CategoryTableViewController.swift
//  Restaurant
//
//  Created by Алексей Сергеев on 15.05.2021.
//  Copyright © 2021 Алексей Сергеев. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // fetch categories and if there is an error, the error will be shown
        MenuController.shared.fetchCategories { (result) in
            switch result {
            case .failure(let error):
                self.displayError(error, title: "Failed to Fetch Categories")
            case .success(let categories):
                self.updateUI(with: categories)
            }
        }
        
    }
    
    private func updateUI(with categories: [String]) {
        DispatchQueue.main.async {
            self.categories = categories
            self.tableView.reloadData()
        }
    }

    private func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBSegueAction func showMenu(_ coder: NSCoder, sender: Any?) -> MenuTableViewController? {
        guard let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) else {
            return nil
        }
        
        let category = categories[indexPath.row]
        return MenuTableViewController(coder: coder, category: category)
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
//         #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)

        let category = categories[indexPath.row]
        cell.textLabel?.text = category.capitalized

        return cell
    }
    
}
