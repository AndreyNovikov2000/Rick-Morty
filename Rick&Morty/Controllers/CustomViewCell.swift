//
//  CustomViewCell.swift
//  Rick&Morty
//
//  Created by Andrey Novikov on 12/13/19.
//  Copyright © 2019 Andrey Novikov. All rights reserved.
//

import UIKit

class CustomViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var chracterImageView: UIImageView! {
        didSet {
            chracterImageView.contentMode = .scaleAspectFit
            chracterImageView.clipsToBounds = true
            chracterImageView.layer.cornerRadius = chracterImageView.bounds.height/2
            chracterImageView.backgroundColor = .white
            
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .white
        }
    }
    @IBOutlet weak var chracterContentView: UIView! {
        didSet {
            chracterContentView.backgroundColor = .black
        }
    }
    
    // MARK: - Public methods
    func configure(with result: Result?) {
        nameLabel.text = result?.name
        DispatchQueue.global().async {
            guard let stringUrl = result?.image else { return }
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.chracterImageView.image = UIImage(data: imageData)
            }
        }
    }
}
