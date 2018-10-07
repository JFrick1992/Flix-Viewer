//
//  MovieDetailsViewController.swift
//  Flix-Viewer
//
//  Created by Jacob Frick on 9/19/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    var movie : Movie!
    
   
    
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = movie.title + " Details"
        releaseDateLabel.text = movie.releaseDate
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        posterImageView.af_setImage(withURL: movie.posterUrl!)
        backdropImageView.af_setImage(withURL: movie.backdropUrl!)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
