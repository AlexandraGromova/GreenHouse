import Foundation

class Pagination {
    
    var totalPages = 7
    var page = 0
    
    func loadMoreContent() -> Int {
        if (page + 1) <= totalPages {
            page += 1
            return page
        }
        else {
            return page
        }
    }
}
