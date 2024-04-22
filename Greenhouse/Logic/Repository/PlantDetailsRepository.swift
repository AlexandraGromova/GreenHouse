import Foundation
import Combine

class PlantDetailsRepository {
    private let remouteSource: RemouteSource
    private let localSource: LocalSource
    
    init(remouteSource: RemouteSource, localSource: LocalSource) {
        self.remouteSource = remouteSource
        self.localSource = localSource
    }
    
    func getPlantDetails(id: Int) async -> Result<APIDetailPlant, HttpError> {
        return await remouteSource.getPlantDetails(id: id)
    }
    
    func getPlantDetailFromStorage(id: Int) -> FavoritePlant? {
        return localSource.getPlantDetails(id: id)
    }
    
}
