//
//  CardsViewController.swift
//  tinder
//
//  Created by Paul Sokolik on 10/11/17.
//  Copyright © 2017 Paul Sokolik. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    
    @IBOutlet weak var cardImageView: DraggableImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cardImageView.image = UIImage(named: "ryan")
    }

}
