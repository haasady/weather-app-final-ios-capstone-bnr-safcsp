//
//  CollectionCell.swift
//  Weto
//
//  Created by Hanan on 30/12/2020.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    var business: Business!
    
    @IBOutlet var storeName: UILabel!
    @IBOutlet var condition: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func update(displaying image: UIImage?) {
        if let imageToDisplay = image {
            spinner.isHidden = true
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            spinner.isHidden = false
            spinner.startAnimating()
            imageView.image = nil
        }
    }
}
