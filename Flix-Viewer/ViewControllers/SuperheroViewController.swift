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
        let posterString = movies[indexPath.item].poster_path!
        let posterpath = Movie.baseImageURL + posterString
        let posterURL = URL(string: posterpath)!
        cell.posterImageView.af_setImage(withURL: posterURL)
        return cell
    }
    func fetchMovies() {
        //self.activityIndicator.startAnimating()
        let urlString = "https://api.themoviedb.org/3/movie/363088/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let moviesDic = dataDictionary["results"] as! [[String: Any]]
                for movieHolder in moviesDic {
                    let title = movieHolder["title"] as! String
                    let poster_path = movieHolder["poster_path"] as! String
                    let overview = movieHolder["overview"] as! String
                    let backdrop_path = movieHolder["backdrop_path"] as! String
                    let release_date = movieHolder["release_date"] as! String
                    let movie = Movie.init(title: title, overview: overview, poster_path: poster_path, backdrop_path: backdrop_path, release_date: release_date)
                    self.movies.append(movie)
                }
                //self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
                //self.refreshControl.endRefreshing()
            }
        }
        task.resume()
        
    }

}
