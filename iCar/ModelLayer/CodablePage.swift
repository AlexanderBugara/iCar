import Foundation

struct KeyValue: Codable, Equatable {
    var name: String
    var value: String
}

struct CodablePage: Page, Equatable, Decodable {
    var page: Int?
    var pageSize: Int?
    var totalPageCount: Int?
    var wkda: [KeyValue]?
    var count: Int {
        guard let wkda = self.wkda else {
            return 0
        }
        return wkda.count
    }
    private enum CodingKeys: String, CodingKey {
        case page
        case pageSize
        case totalPageCount
        case wkda
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodablePage.CodingKeys.self)
        self.page = try container.decode(Int.self, forKey: .page)
        self.pageSize = try container.decode(Int.self, forKey: .pageSize)
        self.totalPageCount = try container.decode(Int.self, forKey: .totalPageCount)
        let wkda = try container.decode([String: String].self, forKey: .wkda)
        self.wkda = wkda.sorted(by: { (first, second) -> Bool in
            return first.value < second.value
        }).map { tuple in
            KeyValue(name: tuple.value, value: tuple.key)
        }
    }
}

