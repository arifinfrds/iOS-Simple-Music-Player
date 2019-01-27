//
//  ViewController.swift
//  Music Player App
//
//  Created by Arifin Firdaus on 1/27/19.
//  Copyright © 2019 Arifin Firdaus. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    fileprivate var songs: [MPMediaItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songs = loadSongs()
        setupTableView()
        setupCell()
        setupNavBar()
    }
    
    fileprivate func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    fileprivate func setupCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    fileprivate func setupNavBar() {
        title = "Songs"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    fileprivate func loadSongs() -> [MPMediaItem]? {
        let mediaItems = MPMediaQuery.songs().items
        return mediaItems
    }
    
    
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = songs?.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let songs = songs else { return cell }
        let song = songs[indexPath.row]
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artist
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let songs = songs else { return }
        let song = songs[indexPath.row]
        
        let mediaCollection = MPMediaItemCollection(items: [song])
        
        let player = MPMusicPlayerController.systemMusicPlayer
        player.setQueue(with: mediaCollection)
        
        player.play()
    }
    
}

