import Foundation

struct API {
    static func apiComponents(path: Constants.Path, queryItems: [URLQueryItem]? = nil) -> URLComponents {
        var components = URLComponents()
        components.scheme = Constants.networkSchema
        components.host = Constants.networkHost
        components.path = path.rawValue
        components.queryItems = queryItems
        return components
    }

    static func apiURL(path: Constants.Path?, params: [String: String]? = nil) -> URL? {
        guard let path = path else {
            return nil
        }
        var queryItems: [URLQueryItem]?
        if let params = params {
            queryItems = params.map { key, value in URLQueryItem(name: key, value: value) }
            return apiComponents(path: path, queryItems: queryItems).url
        }

        return apiComponents(path: path, queryItems: queryItems).url
    }

    static func params(pageIndex: Int, itemsCount: Int) -> [String: String] {
        [
         Constants.pageSize: "\(itemsCount)",
         Constants.wa_key: Constants.wa_key_value,
         Constants.page: "\(pageIndex)"
        ]
    }
}

extension API {
    enum Error: LocalizedError {
        case URLIsNil
        case DataIsNil
    }
}
