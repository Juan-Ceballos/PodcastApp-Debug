//
//  PodcastCell.swift
//  Podcast
//

import UIKit

class PodcastCell: UITableViewCell {

    static let reuseidentifier = "PodcastCell"

    var podcastImage: UIImageView = {
        var iv = UIImageView()
        return iv
    }()

    var collectionName: UILabel = {
        var label = UILabel()
        label.numberOfLines = 3
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupPodcastImageViewConstraints()
        setupCollectionNameConstraints()
    }

    private func setupPodcastImageViewConstraints() {
        addSubview(podcastImage)
        podcastImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            podcastImage.topAnchor.constraint(equalTo: topAnchor),
            podcastImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            podcastImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            podcastImage.widthAnchor.constraint(equalTo: podcastImage.heightAnchor)
        ])
    }

    private func setupCollectionNameConstraints() {
        let padding: CGFloat = 16
        addSubview(collectionName)
        collectionName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionName.leadingAnchor.constraint(equalTo: podcastImage.trailingAnchor, constant: padding),
            collectionName.topAnchor.constraint(equalTo: topAnchor, constant: padding * 2),
            collectionName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        ])
    }

    func configure(with podcast: Podcast) {
        collectionName.text = podcast.collectionName

        ImageLoader.fetchImage(for: podcast.artworkUrl100) { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error fetching image: \(error)")
            case .success(let image):
                self?.podcastImage.image = image
            }
        }
    }
}
