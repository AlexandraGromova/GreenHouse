import Foundation
import Combine

class PlantDetailsVM: ObservableObject {
    
    @Published var plantDetails = UIPlant(id: 0, name: "")
    
    private let getPlantDetailsUC: GetPlantDetailsUC
    
    init(getPlantDetailsUC: GetPlantDetailsUC) {
        self.getPlantDetailsUC = getPlantDetailsUC
    }
    
    func getPlantDetails(id: Int) {
        Task {
            let result = await self.getPlantDetailsUC.execute(id: id)
            switch result {
            case .success(let value):
                DispatchQueue.main.async {
                    self.plantDetails = value
                }
            case .failure(let error):
                print("testResult error \(error)")
            }
        }
    }
}
