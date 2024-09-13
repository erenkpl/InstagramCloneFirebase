//
//  FeedViewController.swift
//  InstagramCloneFirebase
//
//  Created by Eren Küpeli on 29.08.2024.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell // Cell içinde tanımlı her şeye erişebiliyoruz.
        cell.userEmailLabel.text = "text"
        cell.likeLabel.text = "0"
        cell.userCommentLabel.text = "comment"
        cell.userImageView.image = UIImage(named: "select")
        return cell
    }
    
}
