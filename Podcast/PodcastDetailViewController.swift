//
//  PodcastDetailViewController.swift
//  Podcast
//
//  Created by Juan Ceballos on 2/24/22.
//

import UIKit

class PodcastDetailViewController: UIViewController {
    
    var podcast: Podcast?
    var podcastDetailView = PodcastDetailView()
    
    override func loadView() {
        view = podcastDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI(podcast: podcast)
    }
  
    private func configureUI(podcast: Podcast?) {
        guard let podcast = podcast else {
            fatalError()
        }
        
        podcastDetailView.titleLabel.text = podcast.collectionName
    }

}
