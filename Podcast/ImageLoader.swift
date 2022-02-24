//
//  ImageLoader.swift
//  Podcast
//

import UIKit

class ImageLoader {
    enum ImageError: Error {
        case badURL
        case invalidImageData
        case networkError(Error)
    }

    static func fetchImage(for urlString: String, completion: @escaping (Result<UIImage, ImageError>) -> Void ) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.badURL))
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
            } else if let data = data {
                guard let image = UIImage(data: data) else {
                    completion(.failure(.invalidImageData))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(image))
                }
            }
        }

        dataTask.resume()
    }
}
