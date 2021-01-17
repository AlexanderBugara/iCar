import XCTest
@testable import iCar

final class MockNetworkManager: NetworkManaging {
    var isInProgress: Bool = false
    var fetchPath: Constants.Path?
    var queryParams: [String : String]?

    func fetch<CodablePage: Decodable>(path: Constants.Path, queryParams: [String : String], type: CodablePage.Type, completion: @escaping (Result<CodablePage, API.APIError>) -> Void) {
        fetchPath = path
        self.queryParams = queryParams
        let bundle = Bundle(for: MockNetworkManager.self)

        guard let pageIndex = queryParams[Constants.page] else {
            completion(.failure(.WrongParameters))
            return
        }
        guard let path = bundle.path(forResource: "Page\(pageIndex)", ofType: "json"), let data = try? Data(contentsOf: URL(fileURLWithPath: path)), let result = try? JSONDecoder().decode(CodablePage.self, from: data) else {
            return
        }
        completion(.success(result))
    }
}
