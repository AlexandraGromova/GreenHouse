import Foundation
import Alamofire

class RemouteSource {
    
    let key = "sk-iHnv660c6a14100114066"
    
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
    
    func getPlantDetails(id: Int) async -> Result<APIDetailPlant, HttpError> {
        let url = "https://perenual.com/api/species/details/\(id)?key=\(key)"
        print("url = \(url)")
        let response = await AF.request(url, interceptor: .retryPolicy)
            .validate()
            .serializingDecodable(APIDetailPlant.self)
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

enum HttpError: String, Error,CaseIterable {
    case noInternet = "No internet"
    case incorrectJSON = "Incorrect JSON"
    case serverError = "Server Error"
    case unknowError = "Unknow Error"
}
