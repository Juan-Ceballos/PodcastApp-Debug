//
//  ViewController.swift
//  Podcast
//

import UIKit

class PodcastFeedController: UIViewController {

    private let apiClient = APIClient()

    private lazy var tableView: UITableView = {
        var tv = UITableView()
        tv.register(PodcastCell.self, forCellReuseIdentifier: PodcastCell.reuseidentifier)
        tv.dataSource = self
        tv.delegate = self
        return tv
    }()

    private var podcasts: [Podcast] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        searchPodcast()
    }

    private func searchPodcast() {
        apiClient.searchPodcast(with: "") { [weak self] result in
            switch result {
            case .failure(let error):
                print("Searching podcast error: \(error)")
            case .success(let podcasts):
                self?.podcasts = podcasts
            }
        }
    }
}

extension PodcastFeedController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        podcasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PodcastCell.reuseidentifier, for: indexPath) as? PodcastCell else {
            fatalError("Could not dequeue a cell with identifier \(PodcastCell.reuseidentifier)")
        }
        let podcast = podcasts[indexPath.row]
        cell.configure(with: podcast)
        return cell
    }
}

extension PodcastFeedController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dv = PodcastDetailViewController()
        dv.podcast = podcasts[indexPath.row]
        navigationController?.pushViewController(dv, animated: false)
    }
}



