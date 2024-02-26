import SwiftUI
import Combine

struct PlantsListScreen: View {
    
    @StateObject var vm = AppContainer.resolve(PlantsListVM.self)

    var body: some View {
        VStack() {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(Array(vm.plants.enumerated()), id: \.offset) { index, plant in
                        PlantsListSell(image: plant.default_imagels?.small_url ?? "https://perenual.com/storage/species_image/2_abies_alba_pyramidalis/small/49255769768_df55596553_b.jpg", title: plant.common_name, id: "\(plant.id)")
                            .background(Color.lightGray)
                            .cornerRadius(20)
                            .padding(.vertical, 5)
                            .onAppear() {
                                if vm.plants.count - 4 == index {
                                    vm.tryUpdatePlants(currentPage: vm.loadMoreContent())
                                    vm.getPlantsfromLS()
                                }
                            }
                    }
                }
            }
            if vm.error == true {
                Spacer()
                    .frame(height: 0)
                Text("No Internet Connection")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 15))
                    .bold()
                    .frame(width: UIScreen.screenWidth, height: 20 , alignment: .center)
                    .background(Color.red)
            }
        }
    }
}

#Preview {
    PlantsListScreen()
}

struct PlantsListSell: View {
    
    var image: String
    var title: String
    var id: String
    
    @State var isPlaying : Bool = false
    
    var body: some View {
        HStack {
            Spacer()
            AsyncImage(url: URL(string: image)) { image in
                image
                    .resizable()
                    .frame(width: 80, height: 80)
                    .background(Color.gray)
                    .cornerRadius(15)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)
            .background(Color.gray)
            .cornerRadius(15)
            
            Spacer()
            VStack() {
                Spacer()
                Text(title)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 20))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text(id)
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 15))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            Spacer()
            Button(action: {
                self.isPlaying.toggle()
            }) {
                Image(systemName: self.isPlaying == true ? "heart.circle.fill" : "heart.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.horizontal, 8)
                    .foregroundStyle(self.isPlaying == true ? Color.lightGreen : Color.white)
            }
            Spacer()
        }
        .frame(width: UIScreen.screenWidth - 40, height: 100 )
    }
}

extension UIScreen {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}
