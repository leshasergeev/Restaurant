//
//  MenuTableViewController.swift
//  Restaurant
//
//  Created by Алексей Сергеев on 15.05.2021.
//  Copyright © 2021 Алексей Сергеев. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {

    let category: String
    
    var menuItems = [MenuItem]()
    
    init?(coder: NSCoder, category: String){
        self.category = category
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MenuTableViewController: init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MenuController.shared.fetchMenuItems(forCategory: category) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Failed to Fetch Menu Items for \(self.category)", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            case .success(let menuItems):
                DispatchQueue.main.async {
                    self.menuItems = menuItems
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItem", for: indexPath)

        let menuItem = menuItems[indexPath.row]
        
        cell.textLabel?.text        = menuItem.name
        cell.detailTextLabel?.text  = MenuItem.priceFormatter.string(from: NSNumber(value: menuItem.price))

        return cell
    }

    @IBSegueAction func showMenuItem(_ coder: NSCoder, sender: Any?) -> MenuItemDetailViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {
            return nil
        }
        
        let menuItem = self.menuItems[indexPath.row]
        
        return MenuItemDetailViewController(coder: coder, menuItem: menuItem)
    }
    

}
