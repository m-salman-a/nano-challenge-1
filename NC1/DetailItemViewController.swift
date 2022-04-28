//
//  DetailViewController.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 28/04/22.
//

import UIKit

class DetailItemViewController: UIViewController {

    @IBOutlet weak var itemImagesCollectionView: UICollectionView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    @IBOutlet weak var itemLinksTableView: UITableView!
    @IBOutlet weak var itemLikesSegmentedControl: UISegmentedControl!
    @IBOutlet weak var itemLikesTableView: UITableView!
    
    let item: WishItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
