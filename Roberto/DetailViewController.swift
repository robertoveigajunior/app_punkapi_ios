//
//  DetailViewController.swift
//  Roberto
//
//  Created by Roberto Luiz Veiga Junior on 15/07/17.
//  Copyright © 2017 robertoveigajunior. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbAbv: UILabel!
    @IBOutlet weak var lbTagline: UILabel!
    @IBOutlet weak var lbFirstBrewed: UILabel!
    @IBOutlet weak var txtDetail: UITextView!
    
    var beer: Beer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCommon()
    }
    
    func initCommon() {
        UIImage().download(url: beer.imageUrl) { (image) in
            self.imgView.image = image
        }
        self.lbName.text = "Nome: \(beer.name!)"
        self.txtDetail.text = beer.description!
        self.lbAbv.text = "Teor: \(beer.abv!)"
        self.lbTagline.text = "Linha: \(beer.tagline!)"
        if beer.firstBrewed != nil {
            self.lbFirstBrewed.text = "Primeira fermentação \(beer.firstBrewed!)"
        }
    }
}
