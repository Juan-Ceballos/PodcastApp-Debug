//
//  APIClient.swift
//  Podcast
//

import Foundation

struct APIClient {

    enum NetworkError: Error {
        case badURL
        case networkError(Error)
        case decodingError
    }

    func searchPodcast(with name: String, completion: @escaping (Result<[Podcast], NetworkError>) -> Void) {
        let endpoint = "https://itunes.apple.com/search?media=podcast&limit=200&term=swift"

        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            } else if let data = data {
                do {
                    let podcasts = try JSONDecoder().decode(PodcastWrapper.self, from: data).results
                    DispatchQueue.main.async {
                        completion(.success(podcasts))
                    }
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }

        dataTask.resume()

    }
}
