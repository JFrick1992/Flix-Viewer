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
        self.title = movie.title! + " Details"
        releaseDateLabel.text = movie.release_date
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        let urlPoster = URL(string: Movie.baseImageURL + movie.poster_path!)!
        let urlBackDrop = URL(string: Movie.baseImageURL + movie.backdrop_path!)!
        posterImageView.af_setImage(withURL: urlPoster)
        backdropImageView.af_setImage(withURL: urlBackDrop)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
