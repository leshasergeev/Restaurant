//
//  MenuItemDetailViewController.swift
//  Restaurant
//
//  Created by Алексей Сергеев on 20.05.2021.
//  Copyright © 2021 Алексей Сергеев. All rights reserved.
//

import UIKit

class MenuItemDetailViewController: UIViewController {

    let menuItem: MenuItem!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var detailTextLabel: UILabel!
    
    @IBOutlet weak var addToOrderButton: UIButton!
    
    init?(coder: NSCoder, menuItem: MenuItem) {
        self.menuItem = menuItem
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("MenuItemDetailViewController's init(coder:) has not been implemented")
    }
    
    @IBAction func addToOrderButtonTapped(_ sender: UIButton) {
        
        MenuController.shared.order.menuItems.append(menuItem)
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.8, y: 1.8)
            self.addToOrderButton.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToOrderButton.layer.cornerRadius = 5.0
        
        updateUI()
    }
    
    func updateUI() {
        nameLabel.text       = menuItem.name
        detailTextLabel.text = menuItem.detailText
        priceLabel.text      = MenuItem.priceFormatter.string(from: NSNumber(value: menuItem.price))
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
