//
//  NowPlayingViewController.swift
//  Flix-Viewer
//
//  Created by Jacob Frick on 9/13/18.
//  Copyright © 2018 Jacob Frick. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var refreshControl: UIRefreshControl!
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]()
    
    
    struct Movie {
        let title : String?
        let overview : String?
        let poster_path: String?
        let backdrop_path: String?
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        fetchMovies()
        
        // Do any additional setup after loading the view.
    }

    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
    }
    func fetchMovies() {
        self.activityIndicator.startAnimating()
        let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
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
                    let movie = Movie.init(title: title, overview: overview, poster_path: poster_path, backdrop_path: backdrop_path)
                    self.movies.append(movie)
                }
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let title = movies[indexPath.row].title
        let overview = movies[indexPath.row].overview
        let posterPath = movies[indexPath.row].poster_path
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURLString + posterPath!)!
        cell.posterImageView.af_setImage(withURL: posterURL)
        return cell
    }
    

}
