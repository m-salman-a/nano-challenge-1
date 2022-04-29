//
//  EditItemViewController.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 29/04/22.
//

import Foundation
import UIKit

class EditItemViewController: UIViewController, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var itemName = ""
    var itemPrice = 0.00
    private var images = [UIImage]()
    var imagesData = [Data]()
    var links = [Link]()
    var categories = [WishCategory]()
    var selectedCategory: WishCategory?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var editImagesCollection: UICollectionView!
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemPriceField: UITextField!
    @IBOutlet weak var itemCategoryPopup: UIButton!
    @IBOutlet weak var itemLinksTable: UITableView!
    @IBOutlet weak var itemLinksTableHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editImagesCollection.register(UINib(nibName: "EditImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EditImagesCollectionViewCell")
        editImagesCollection.dataSource = self
        
        itemPriceField.textContentType = .telephoneNumber
        itemPriceField.keyboardType = .decimalPad
        
        imagePicker.delegate = self
        
        itemLinksTable.register(UINib(nibName: "EditItemTableViewHeader", bundle: nil), forCellReuseIdentifier: "EditItemTableViewHeader")
        itemLinksTable.register(UINib(nibName: "EditItemTableViewCell", bundle: nil), forCellReuseIdentifier: "EditItemTableViewCell")
        itemLinksTable.dataSource = self
        itemLinksTable.delegate = self
        
        initializeCategoryPopup()
    }

    @IBAction func addImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        itemName = itemNameField.text ?? "Empty"
        itemPrice = Double(itemPriceField.text ?? "00.00") ?? 0.0
        images.forEach {
            guard let data = $0.pngData() else { return }
            
            imagesData.append(data)
        }
    }
    
    func initializeCategoryPopup() {
        let actions = categories.map {
            category in
            UIAction(title: NSLocalizedString(category.name, comment: "")) {
                action in
                self.selectedCategory = category
            }
        }
        let emptyAction = UIAction(title: NSLocalizedString("No Category", comment: "")) {
            _ in
            self.selectedCategory = nil
        }
        itemCategoryPopup.menu = UIMenu(title: "Select one", children: [emptyAction] + actions)
        itemCategoryPopup.showsMenuAsPrimaryAction = true
    }
}

extension EditItemViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            images.append(pickedImage)
            
            editImagesCollection.reloadData()
        }
     
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

extension EditItemViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditImagesCollectionViewCell", for: indexPath) as! EditImagesCollectionViewCell
        
        cell.delegate = self
        cell.index = indexPath.row
        cell.image.contentMode = .scaleAspectFit
        cell.image.image = images[indexPath.row]
        
        return cell
    }
}

extension EditItemViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return links.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EditItemTableViewCell") as! EditItemTableViewCell
        let link = links[indexPath.row]
        
        cell.delegate = self
        cell.index = indexPath.row
        cell.placeholderLabel.text = link.placeholder
        cell.urlLabel.text = link.url
    
        return cell
    }
}

extension EditItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableCell(withIdentifier: "EditItemTableViewHeader") as! EditItemTableViewHeader
        
        view.delegate = self
        view.headerLabel.text = "Links"
        
        return view
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            [weak self] (action, view, handler) in
            
            self?.links.remove(at: indexPath.row)
            
            self?.itemLinksTable.reloadData()
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])

    }
}

extension EditItemViewController: EditItemTableViewProtocol {
    func didFinishEditing(url: String, placeholder: String, index: Int) {
        links[index] = Link(url: url, placeholder: placeholder)
    }
}

extension EditItemViewController: EditItemTableViewHeaderProtocol {
    func addItem() {
        
        links.append(Link(url: "", placeholder: ""))
        
        itemLinksTableHeightConstraint.constant = CGFloat(links.count * 80 + 50)
        
        scrollView.contentInset.bottom = itemLinksTable.contentSize.height
        
        itemLinksTable.reloadData()
    }
}

extension EditItemViewController: EditImagesCollectionViewProtocol {
    func deleteImage(index: Int) {
        images.remove(at: index)
        
        editImagesCollection.reloadData()
    }
}

