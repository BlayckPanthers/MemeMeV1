//
//  MemeTableViewController.swift
//  MemeMeV1
//
//  Created by Fabien Lebon on 12/04/2020.
//  Copyright © 2020 Fabien Lebon. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    struct Spacing {
        static let space: CGFloat = 5.0
    }

    struct Cell {
        static let indentifier: String = "TableCell"
    }
    
    private var memes:[Meme]! {
       return (UIApplication.shared.delegate as! AppDelegate).memes
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView!.reloadData()
    }
    
    // MARK: - Table view data source
    
    // Use section instead of row to set a spacing between each row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Spacing.space
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.indentifier, for: indexPath) as! MemeTableViewCell
        let meme = memes[indexPath.section]
        
        cell.memeName?.text     = "\(meme.topText) ... \(meme.bottomText)"
        cell.memeImage.image    = meme.memedImage

        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.section]
        self.navigationController!.pushViewController(detailController, animated: true)

    }
    
    
}
