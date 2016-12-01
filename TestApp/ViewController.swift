//
//  ViewController.swift
//  StickyHeader
//
//  Created by Yannick Heinrich on 25.08.16.
//  Copyright © 2016 yageek. All rights reserved.
//

import UIKit
import StickyHeader

class ViewController: UICollectionViewController {


    let headerView: UIView = {

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 100))
        view.backgroundColor = UIColor.blue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.stickyHeader.view = self.headerView
        self.collectionView?.stickyHeader.height = 200
        self.collectionView?.stickyHeader.minimumHeight = 100

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier:"Cell", for: indexPath)
    }
}
