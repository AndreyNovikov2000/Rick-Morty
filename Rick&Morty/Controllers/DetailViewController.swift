//
//  DetailViewController.swift
//  Rick&Morty
//
//  Created by Andrey Novikov on 12/13/19.
//  Copyright © 2019 Andrey Novikov. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var chracterImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    // MARK: - Public properties
    var chracter: Result!
    
    // MARK: - UIViewController Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupChracterImageView()
        view.backgroundColor = .black
        transform(for: chracterImageView,
                  nameAnimation: "transform.scale",
                  duration: 0.7,
                  fromValue: 0.97,
                  toValue: 1.93,
                  autoreverses: true,
                  repeatCount: Float.greatestFiniteMagnitude)
        
        setupLabels()
        setupNavigationBar()
    }
    
    // MARK: - Private methods
    
    private func setupChracterImageView() {
        chracterImageView.layer.cornerRadius = chracterImageView.bounds.width/2
        chracterImageView.image = UIImage(named: "bi")
        chracterImageView.backgroundColor = .white
            
        DispatchQueue.global().async {
            let stringUrl = self.chracter.image
            guard let imageUrl = URL(string: stringUrl) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            DispatchQueue.main.async {
                self.chracterImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    private func setupLabels() {
        nameLabel.text = "My name is \(chracter.name)"
        statusLabel.text = "Status - \(chracter.status)"
        speciesLabel.text = "Species - \(chracter.species)"
        genderLabel.text = "Gender - \(chracter.gender)"
        originLabel.text = "Origin - \(chracter.origin.name)"
        locationLabel.text = "Location - \(chracter.location.name)"
    }
    
    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = nil
        title = chracter.name
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
    }
}

