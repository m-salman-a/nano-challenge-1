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
    var images: [UIImage] = []
    var categories = [WishCategory]()
    
    @IBOutlet weak var editImagesCollectionView: UICollectionView!
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var itemPriceField: UITextField!
    @IBOutlet weak var itemCategoryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        editImagesCollectionView.register(UINib(nibName: "EditImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EditImagesCollectionViewCell")
        editImagesCollectionView.dataSource = self
        
        itemPriceField.textContentType = .telephoneNumber
        itemPriceField.keyboardType = .decimalPad
        
        imagePicker.delegate = self
        
        itemCategoryPicker.dataSource = self
        itemCategoryPicker.delegate = self
        itemCategoryPicker.reloadAllComponents()
    }
    
    @IBAction func addImage(_ sender: Any) {
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveItem(_ sender: Any) {
        // Should validate user input here
    }
}

extension EditItemViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            images.append(pickedImage)
            
            editImagesCollectionView.reloadData()
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

extension EditItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if row == 0 {
            return ""
        }
        
        return categories[row - 1].name
    }
}

extension EditItemViewController: UIPickerViewDelegate {
    
}

extension EditItemViewController: EditImagesCollectionViewProtocol {
    func deleteImage(index: Int) {
        images.remove(at: index)
        
        editImagesCollectionView.reloadData()
    }
}

