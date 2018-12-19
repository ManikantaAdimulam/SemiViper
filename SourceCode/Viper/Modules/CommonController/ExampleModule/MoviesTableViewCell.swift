//
//  MoviesTableViewCell.swift
//  Viper
//
//  Created by Manikanta on 12/12/18.
//  Copyright © 2018 Siddhant Jain. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    ///
    @IBOutlet weak var thumbnailImageView: UIImageView!
    ///
    @IBOutlet weak var movieNameLabel: UILabel!
    ///
    @IBOutlet weak var movieRatingLabel: UILabel!
    ///
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - UI Methods
    func setupCell(movie: Movie) {
        movieNameLabel.text = movie.name
        movieRatingLabel.text = movie.rating
        movieDescriptionLabel.text = movie.description
        if let url = URL(string: movie.thumbnailUrl) {
            thumbnailImageView.load(url: url)
        }
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
