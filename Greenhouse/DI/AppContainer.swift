import Foundation
import Swinject

class AppContainer {
    
    static private let container = Container()
    
    static func setup() {
        container.register(RemouteSource.self) { r in
            RemouteSource()
        }
        container.register(LocalSource.self) { r in
            LocalSource()
        }
        container.register(Pagination.self) { r in
            Pagination()
        }
        container.register(PlantsRepository.self) { r in
            PlantsRepository(remouteSource: r.resolve(RemouteSource.self)!, localSource: r.resolve(LocalSource.self)!)
        }
        container.register(GetPlantsUC.self) { r in
            GetPlantsUC(plantsRepository: r.resolve(PlantsRepository.self)!)
        }
        container.register(PlantsListVM.self) { r in
            PlantsListVM(getPlantUC: r.resolve(GetPlantsUC.self)!, plantsRepository: r.resolve(PlantsRepository.self)!, pagination: r.resolve(Pagination.self)! )
        }
        
    }
    
    static func resolve<T>(_ serviceType: T.Type) -> T {
         return container.resolve(serviceType)!
     }
}
