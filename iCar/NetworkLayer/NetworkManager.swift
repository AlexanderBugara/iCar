import Foundation

protocol NetworkManaging {
    var isInProgress: Bool { get }
    func fetch<T>(path: Constants.Path, queryParams: [String: String], type: T.Type, completion: @escaping (Result<T,API.APIError>) -> Void) where T : Decodable
}

final class NetworkManager {
    var isInProgress: Bool = false
    var urlSession: URLSession?

    init(urlSession: URLSession? = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension NetworkManager: NetworkManaging {
    func fetch<T>(path: Constants.Path, queryParams: [String: String], type: T.Type, completion: @escaping (Result<T,API.APIError>) -> Void) where T : Decodable {

        guard let url = API.apiURL(path: path, params: queryParams) else {
            completion(.failure(.URLIsNil))
            return
        }

        isInProgress = true
        let task = urlSession?.dataTask(with: url) { [weak self] data, response, error in
            do {
                guard let data = data else {
                    DispatchQueue.main.async {
                        self?.isInProgress = false
                        completion(.failure(.DataIsNil))
                    }
                    return
                }
                let reult = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    self?.isInProgress = false
                    completion(.success(reult))
                }
            } catch {
                completion(.failure(error as! API.APIError))
            }
        }
        task?.resume()
    }
}
