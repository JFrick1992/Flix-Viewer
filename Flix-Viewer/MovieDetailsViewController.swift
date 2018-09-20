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
    var movie : NowPlayingViewController.Movie!
    
   
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        releaseDateLabel.text = movie.release_date
        titleLabel.text = movie.title
        overviewTextView.text = movie.overview
        let urlPoster = URL(string: NowPlayingViewController.Movie.baseImageURL + movie.poster_path!)!
        let urlBackDrop = URL(string: NowPlayingViewController.Movie.baseImageURL + movie.backdrop_path!)!
        posterImageView.af_setImage(withURL: urlPoster)
        backdropImageView.af_setImage(withURL: urlBackDrop)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
