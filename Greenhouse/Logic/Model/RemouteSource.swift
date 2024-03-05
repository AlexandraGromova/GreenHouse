import Foundation
import Alamofire

class RemouteSource {
    
    func getResponsePlants(currentPage: Int) async -> Result<ResponsePlants, HttpError> {
        let url = "https://perenual.com/api/species-list?key=sk-IArD65c38bf2323734066&indoor=1&page=\(currentPage)"
        print("url = \(url)")
        let response = await AF.request(url, interceptor: .retryPolicy)
            .validate()
            .serializingDecodable(ResponsePlants.self)
            .response.mapError { error in
                print("test \(error)")
                let customError = switch error {
                case .sessionTaskFailed(_):
                    HttpError.noInternet
                case .responseValidationFailed(_):
                    HttpError.serverError
                case .responseSerializationFailed(_):
                    HttpError.incorrectJSON
                default:
                    HttpError.unknowError
                }
                return customError
            }
            .result
        return response
    }
    
}

enum HttpError: Error {
    case noInternet
    case incorrectJSON
    case serverError
    case unknowError
}
