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
                print("last_page \(self.lastPage)")
            }
        }
    }
    
    func getSearchTotalPages() {
        print("first")
        print("getSearchTotalPages_lastPage1  \(lastPage)")
        lastPage = searchRepository.lastPage
        print("getSearchTotalPages_lastPage2 \(lastPage)")
    }
    
    func getNewValuesPage() -> Int {
        print("getNewValuesPage_lastPage \(lastPage)")
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
