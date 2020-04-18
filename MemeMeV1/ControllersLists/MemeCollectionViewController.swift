//
//  MemeCollectionViewController.swift
//  MemeMeV1
//
//  Created by Fabien Lebon on 12/04/2020.
//  Copyright © 2020 Fabien Lebon. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet var flowLayout: UICollectionViewFlowLayout!
    
    private var memes:[Meme]! {
       return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    struct Cell {
        static let identifier = "CollectionCell"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        collectionView!.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let space: CGFloat = 1.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! MemeCollectionViewCell
        let meme = memes[indexPath.row]
        
        // Configure the cell
        cell.memeImage.image = meme.memedImage
        
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }

}
