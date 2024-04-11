import Foundation
import Alamofire

class RemouteSource {
    
    let key = "sk-3uSe660c99e04ad6d4973"
    
    func getResponsePlants(currentPage: Int) async -> Result<ResponsePlants, HttpError> {
        let url = "https://perenual.com/api/species-list?key=\(key)&indoor=1&page=\(currentPage)"
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
    
    func getSearchResponsePlants(currentPage: Int, watering: String, sunlight: String) async -> Result<ResponsePlants, HttpError> {
            let url = "https://perenual.com/api/species-list?key=\(key)&indoor=1&page=\(currentPage)&watering=\(watering)&sunlight=\(sunlight)"
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
    
    func getDetailPlant(id: Int) async -> Result<APIPlant, HttpError> {
        let url = "https://perenual.com/api/species/details/\(id)?key=\(key)"
        print("url = \(url)")
        let response = await AF.request(url, interceptor: .retryPolicy)
            .validate()
            .serializingDecodable(APIPlant.self)
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
