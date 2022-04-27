//
//  ViewController.swift
//  NC1
//
//  Created by Mohammad Alfarisi on 27/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var wishlistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        wishlistTableView.dataSource = self
        wishlistTableView.delegate = self
    }

    @IBAction func addNewItemAction(_ sender: Any) {
        
    }
    
    @IBAction func compareItemsAction(_ sender: Any) {
        
    }
    
    @IBAction func addNewFolderAction(_ sender: Any) {
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
}
