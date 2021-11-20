//
//  MovieCollectionViewCell.swift
//  MovieList
//
//  Created by Erva Hatun Tekeoğlu on 20.11.2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    var cornerRadius: CGFloat = 5.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // Apply rounded corners to contentView
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
                
        // Set masks to bounds to false to avoid the shadow
        // from being clipped to the corner radius
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        moviePoster.layer.cornerRadius = cornerRadius
        moviePoster.clipsToBounds = true

    }

    
}
