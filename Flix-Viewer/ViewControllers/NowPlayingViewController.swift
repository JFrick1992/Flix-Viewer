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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableViewAutomaticDimension
        fetchMovies()

    }

    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
    }
    func fetchMovies() {
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let moviesDetail = segue.destination as! MovieDetailsViewController
        let cell = sender as! MovieCell
        let indexPath = tableView.indexPath(for: cell)!
        moviesDetail.movie = movies[indexPath.row]
        cell.setSelected(false, animated: false)
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
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.posterImageView.af_setImage(withURL: movies[indexPath.row].posterUrl!)
        return cell
    }
}
