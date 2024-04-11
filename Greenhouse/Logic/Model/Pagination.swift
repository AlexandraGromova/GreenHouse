import Foundation

class Pagination {
    
    private let repository: PlantsRepository
    private let searchRepository: SearchPlantsRepository
    
    init(repository: PlantsRepository, searchRepository: SearchPlantsRepository) {
        self.repository = repository
        self.searchRepository = searchRepository
        getTotalPages()
    }
    var lastPage = 1
    var page = 0
    
    func getTotalPages() {
        Task {
            let bufferValue = await repository.getTotalPages()
            DispatchQueue.main.async {
                self.lastPage = bufferValue
//                print("last_page \(self.lastPage)")
            }
        }
    }
    
    func getSearchTotalPages() {
        Task {
            let bufferValue = await searchRepository.getTotalPages()
            DispatchQueue.main.async {
                self.lastPage = 0
                self.lastPage = bufferValue
            }
        }
    }
    
    func getNewValuesPage() -> Int {
        if (page + 1) <= lastPage {
            page += 1
            return page
        }
        else {
            return page
        }
    }
    
    func updateValuePage() {
        page = 0
    }
}
