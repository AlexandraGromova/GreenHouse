import Foundation
import Combine
import SwiftUI

class FavoriteListVM: ObservableObject {
    
    private let repository: FavoriteListRepository
    
    @Published var plants: [UIPlant] = []
    private var cancellables = Set<AnyCancellable>()
    
    
    init(repository: FavoriteListRepository) {
        self.repository = repository
        getFavoritePlants()
    }
    
    func getFavoritePlants() {
        repository.getPlants()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {completion in
            }, receiveValue: {value in
                var bufferList: [UIPlant] = []
                bufferList = value
                withAnimation {
                    self.plants = bufferList
                }
            })
            .store(in: &cancellables)
    }
    
    func saveFavoritePlant(plant: UIPlant) {
        repository.savePlant(plant: plant)
    }

    func deletePlant(plantID: Int) {
        repository.deletePlant(plantID: plantID)
    }
}
