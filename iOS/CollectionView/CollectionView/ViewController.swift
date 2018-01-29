//
//  ViewController.swift
//  CollectionView
//
//  Created by Akash Pomal on 28/01/18.
//  Copyright © 2018 Akash Pomal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var addButton: UIBarButtonItem!
    
    @IBOutlet private weak var deleteButton: UIBarButtonItem!
    
    @IBAction func deleteItem() {
        if let selected = collectionView.indexPathsForSelectedItems {
            let items = selected.map{$0.item}.sorted().reversed()
            for item in items {
                collectionData.remove(at: item)
            }
            collectionView.deleteItems(at: selected)
            navigationController?.isToolbarHidden = true
        }
    }
    
    @IBAction func addItem() {
        let text = "\(collectionData.count+1) 😸"
        collectionData.append(text)
        let index = IndexPath(row: collectionData.count - 1, section: 0)
        collectionView.insertItems(at: [index])
    }
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var collectionData = ["1 🏆", "2 🐸", "3 🍩", "4 😸", "5 🤡", "6 👾", "7 👻", "8 👩‍🎤", "9 🎸", "10 🍖", "11 🐯", "12 🌋"]
    
    @objc func refresh() {
        addItem()
        collectionView.refreshControl?.endRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        collectionView.refreshControl = refresh
        
        let width = (view.frame.size.width - 20) / 3
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = CGSize(width: width, height: width)
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationController?.isToolbarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailSegue" {
            if let destination = segue.destination as? DetailViewController,
                let index = sender as? IndexPath {
                destination.selection = collectionData[index.row]
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addButton.isEnabled = !editing
        collectionView.allowsMultipleSelection = editing
        let indexes = collectionView.indexPathsForVisibleItems
        for index in indexes {
            let cell = collectionView.cellForItem(at: index) as! CollectionViewCell
            cell.isEditing = editing
        }
        if !editing {
            navigationController?.isToolbarHidden = true
        }
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)
//        if let label = cell?.viewWithTag(100) as? UILabel {
//            print(label.text!)
//        }
//        print(collectionData[indexPath.row])
        if !isEditing {
            performSegue(withIdentifier: "DetailSegue", sender: indexPath)
        } else {
            navigationController?.isToolbarHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if isEditing {
            if let selected = collectionView.indexPathsForSelectedItems,
                selected.count == 0 {
                navigationController?.isToolbarHidden = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.titleLabel.text = collectionData[indexPath.row]
            cell.isEditing = isEditing
        return cell
    }
    
    
}
