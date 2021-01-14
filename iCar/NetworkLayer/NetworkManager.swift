import Foundation

protocol NetworkManaging {
    var isInProgress: Bool { get }
    func fetch<T>(pageIndex: Int, itemsCount: Int, type: T.Type, completion: @escaping (Result<T,API.Error>) -> Void) where T : Decodable
}

final class NetworkManager {
    var isInProgress: Bool = false
    var urlSession: URLSession?

    init(urlSession: URLSession? = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension NetworkManager: NetworkManaging {
    func fetch<T>(pageIndex: Int, itemsCount: Int, type: T.Type, completion: @escaping (Result<T,API.Error>) -> Void) where T : Decodable {

        guard let url = API.apiURL(path: .manufacturers, params: API.params(pageIndex: pageIndex, itemsCount: itemsCount)) else {
            completion(.failure(.URLIsNil))
            return
        }
        let task = urlSession?.dataTask(with: url) { data, response, error in
            do {
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(.DataIsNil))
                    }
                    return
                }
                let reult = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(reult))
                }
            } catch {
//              fatalError(error.localizedDescription)
            }
        }
        task?.resume()
    }
}
