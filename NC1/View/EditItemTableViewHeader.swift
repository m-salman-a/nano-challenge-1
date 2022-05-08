//
//  EditItemTableHeaderView.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 29/04/22.
//

import UIKit

protocol EditItemTableViewHeaderProtocol {
    func addItem()
}

class EditItemTableViewHeader: UITableViewCell {

    var delegate: EditItemTableViewHeaderProtocol?
    
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBAction func addItem(_ sender: Any) {
        delegate?.addItem()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
