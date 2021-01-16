import Foundation

enum Constants {
    static let manufacurerCellId = "manufacturer.cell.id"
    static let networkHost = "api-aws-eu-qa-1.auto1-test.com"
    static let networkSchema = "http"
    static let page = "page"
    static let pageSize: String = "pageSize"
    static let itemsCount = 15
    static let wa_key: String = "wa_key"
    static let wa_key_value: String = "coding-puzzle-client-449cc9d"
    static let manufacturer = "manufacturer"
    enum Path: String {
        case manufacturers = "/v1/car-types/manufacturer"
        case models = "/v1/car-types/main-types"
    }
}
