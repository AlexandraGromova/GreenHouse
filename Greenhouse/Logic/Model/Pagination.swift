import Foundation

class Pagination {
    
    private let repository: PlantsRepository
    
    init(repository: PlantsRepository) {
        self.repository = repository
        getTotalPages()
    }
    var totalPages = 1
    //todo
    var lastPages = 3
    //todo
    var page = 0
    
    func getTotalPages() {
        Task {
            let bufferValue = await repository.getTotalPages()
            DispatchQueue.main.async {
                self.totalPages = bufferValue
            }
        }
    }
    //todo
    func getNewValuesSearchPage() -> Int {
        if (page + 1) <= lastPages {
            page += 1
            return page
        }
        else {
            return page
        }
    }
    //todo
    func getNewValuesPage() -> Int {
        if (page + 1) <= totalPages {
            page += 1
            return page
        }
        else {
            return page
        }
    }
}
