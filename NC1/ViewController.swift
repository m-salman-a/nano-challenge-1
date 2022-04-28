//
//  ViewController.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 27/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    var wishItemsObservable: WishItemsObservable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        wishlistTableView.dataSource = self
        wishlistTableView.delegate = self
        
        guard wishItemsObservable != nil else {
            fatalError("This view needs its observable")
        }
        
        wishItemsObservable.fetchWishItems()
    }
    
    @IBOutlet weak var wishlistTableView: UITableView!
    

    @IBAction func addNewItem(_ sender: Any) {
        performSegue(withIdentifier: "goToEdit", sender: self)
    }
    
    @IBAction func compareItems(_ sender: Any) {
        
    }
    
    @IBAction func addNewFolder(_ sender: Any) {
        
    }
}

extension ViewController: Observer {
    func update(with: Observable) {
        // Reflect changes in the UI
        
        wishlistTableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishItemsObservable.wishItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistTableViewCell")!

        var content = cell.defaultContentConfiguration()
        
        let item = wishItemsObservable.wishItems[indexPath.row]
        
        content.text = item.name
        content.image = UIImage()
        content.secondaryText = "\(item.priceString)"
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame:
                CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))

        headerView.backgroundColor = .red

//        let label = UILabel()
//
//        label.frame = CGRect.init(x: 0, y: 0, width: headerView.frame.width, height: headerView.frame.height)

//        headerView.addSubview(label)

        return headerView
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let item = wishItemsObservable.wishItems[indexPath.row]
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            (action, view, handler) in
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] (action, view, handler) in
            
            self?.wishItemsObservable.deleteWishItem(id: item.id)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
