//
//  SavedListCell.swift
//  PhotoNote
//
//  Created by Andre Wolfsky on 23.11.2021.
//

import UIKit

class SavedListCell: UICollectionViewCell {

    @IBOutlet weak var productImage: UIImageView!
    
    override func awakeFromNib() {
            super.awakeFromNib()
        }
    
    override func prepareForReuse() -> Void {
        productImage.image = nil
    }
    
    func configureCell(image: UIImage) {
        contentView.backgroundColor = .yellow
        contentView.layer.cornerRadius = 10
        productImage.backgroundColor = .clear
        productImage.image = image
        productImage.contentMode = .scaleAspectFill
    }
    
}
