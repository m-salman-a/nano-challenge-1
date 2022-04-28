//
//  EditImagesCollectionViewCell.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import UIKit

protocol EditImagesCollectionViewProtocol {
    func deleteImage(index: Int)
}

class EditImagesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    var index: Int?
    
    var delegate: EditImagesCollectionViewProtocol?
    
    @IBAction func deleteImage(_ sender: Any) {
        delegate?.deleteImage(index: index ?? 0)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
