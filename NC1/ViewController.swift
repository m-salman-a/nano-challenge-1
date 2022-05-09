//
//  ViewController.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 27/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    var wishItemsObservable: WishItemsObservable!
    var wishCategoriesObservable: WishCategoriesObservable!
    var selectedItem: WishItem? = nil
    
    // TODO: refactor
    var groupedWishItems = [[WishItem]]()
    func groupItemsByCategory(items: [WishItem], categories: [WishCategory]) -> [[WishItem]] {
        var groupedItems = [[WishItem]]()
        
        groupedItems.append(items.filter {
            $0.category == nil
        })
        
        categories.forEach {
            category in
            groupedItems.append(items.filter {
                $0.category?.name == category.name
            })
        }
        
        return groupedItems
    }
    
    
    @IBOutlet weak var wishlistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        wishlistTableView.register(UINib(nibName: "WishlistTableViewCell", bundle: nil), forCellReuseIdentifier: "WishlistTableViewCell")
        wishlistTableView.dataSource = self
        wishlistTableView.delegate = self
        
        guard wishItemsObservable != nil else {
            fatalError("This view needs its observable")
        }
        
        guard wishCategoriesObservable != nil else {
            fatalError("This view needs its observable")
        }
        
        wishItemsObservable.addListener(self)
        wishCategoriesObservable.addListener(self)
        
        wishItemsObservable.fetchWishItems()
        wishCategoriesObservable.fetchWishCategories()
    }
    
    @IBAction func addNewItem(_ sender: Any) {
        performSegue(withIdentifier: "goToEdit", sender: self)
    }
    
    @IBAction func addNewFolder(_ sender: Any) {
        // Declare Alert message
        let alert = UIAlertController(title: "Add New Category", message: "Enter the name of the category", preferredStyle: .alert)
        
        // Add text field
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Type in the name of the category"
        })
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: {
            [weak self] (action) -> Void in
            guard let text = alert.textFields?[0].text else { return }
            
            self?.wishCategoriesObservable.createWishCategories(
                category: WishCategory(name: text)
            )
        })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        // Present alert message to user
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToEdit" {
            let dest = segue.destination as! EditItemViewController
            
            dest.item = selectedItem
            dest.categories = wishCategoriesObservable.wishCategories
        }
    }
    
    @IBAction func unwindFromAddItem(_ sender: UIStoryboardSegue) {
        if sender.source is EditItemViewController {
            let source = sender.source as! EditItemViewController
            
            guard let item = source.item else { return }
            
            wishItemsObservable.editWishItem(item: item)
            
            // If there is selection
            if let index = wishlistTableView.indexPathForSelectedRow {
                selectedItem = nil
                DispatchQueue.main.async { [weak self] in
                    self?.wishlistTableView.deselectRow(at: index, animated: true)
                }
            }
        }
    }
}

extension ViewController: Observer {
    func update(with: Observable) {
        // Reflect changes in the UI
        groupedWishItems = groupItemsByCategory(
            items: wishItemsObservable.wishItems,
            categories: wishCategoriesObservable.wishCategories
        )
        
        DispatchQueue.main.async { [weak self] in
            self?.wishlistTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedWishItems[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WishlistTableViewCell") as! WishlistTableViewCell
        
        let item = groupedWishItems[indexPath.section][indexPath.row]
        
        cell.titleLabel.text = item.name
        cell.secondaryTitleLabel.text = item.priceString
        if let imageData = item.images.first {
            if let image = UIImage(data: imageData) {
                cell.imageOutlet.image = image
            }
        }

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupedWishItems.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section != 0 else { return UIView() }
        
        guard !groupedWishItems[section].isEmpty else { return UIView() }
        
        let headerView = UIView.init(frame:
                CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        
        let titleLabel = UILabel(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 30))
        titleLabel.font = .systemFont(ofSize: 24.0, weight: .bold)
        titleLabel.text = wishCategoriesObservable.wishCategories[section - 1].name
        
        headerView.addSubview(titleLabel)

        return headerView
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let link = groupedWishItems[indexPath.section][indexPath.row].links.first?.url else {
            return
        }
        
        if let url = NSURL(string: link) as? URL {
            UIApplication.shared.open(url, completionHandler: {
                [weak self] isComplete in
                
                self?.wishlistTableView.deselectRow(at: indexPath, animated: true)
            })
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let item = groupedWishItems[indexPath.section][indexPath.row]
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") {
            [weak self] (action, view, handler) in
            
            self?.selectedItem = self?.groupedWishItems[indexPath.section][indexPath.row]
            
            self?.performSegue(withIdentifier: "goToEdit", sender: self)
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] (action, view, handler) in
            
            self?.wishItemsObservable.deleteWishItem(id: item.id)
            
            tableView.deleteRows(at: [indexPath], with: .right)
            
            self?.wishCategoriesObservable.fetchWishCategories()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
}

