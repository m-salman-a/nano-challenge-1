//
//  EditItemTableViewCell.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 29/04/22.
//

import UIKit

protocol EditItemTableViewProtocol {
    func didFinishEditing(url: String, placeholder: String, index: Int)
}

class EditItemTableViewCell: UITableViewCell {

    @IBOutlet weak var placeholderLabel: UITextField!
    @IBOutlet weak var urlLabel: UITextField!
    
    var delegate: EditItemTableViewProtocol?
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editPlaceholderField(_ sender: Any) {
        delegate?.didFinishEditing(url: urlLabel.text ?? "",
                                   placeholder: placeholderLabel.text ?? "",
                                   index: index ?? 0)
    }
    @IBAction func editUrlField(_ sender: Any) {
        delegate?.didFinishEditing(url: urlLabel.text ?? "",
                                   placeholder: placeholderLabel.text ?? "",
                                   index: index ?? 0)
    }
}
