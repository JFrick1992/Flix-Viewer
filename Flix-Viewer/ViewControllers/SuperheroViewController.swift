//
//  SuperheroViewController.swift
//  Flix-Viewer
//
//  Created by Jacob Frick on 9/20/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource {
    var movies = [Movie]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        fetchMovies()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let movieDetails = segue.destination as! MovieDetailsViewController
        let cell = sender as! PosterCell
        let index = collectionView.indexPath(for: cell)!
        movieDetails.movie = movies[index.item]
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        
        cell.posterImageView.af_setImage(withURL: movies[indexPath.item].posterUrl!)
        return cell
    }
    func fetchMovies() {
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.collectionView.reloadData()
            }
        }
    }
}
