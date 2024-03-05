import SwiftUI
import Combine

struct PlantsListScreen: View {
    
    @StateObject var vm = AppContainer.resolve(PlantsListVM.self)
    
    var body: some View {
        VStack() {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(Array(vm.plants.enumerated()), id: \.element) { index, plant in
                        NavigationLink(destination: PlantDetailScreen(plant: plant)) {
                            PlantsListSell(plant: plant) { plant in
                                vm.savePlant(plant: plant)
                            } onDeleteTapAction: { id in
                                vm.deletePlant(plantID: id)
                            }
                            .background(Color.lightGray)
                            .cornerRadius(20)
                            .padding(.vertical, 5)
                            .onAppear() {
                                if vm.plants.count - 4 == index {
                                    vm.tryUpdatePlants()
                                }
                            }
                        }
                    }
                }
            }
            if !vm.hasError {
                Spacer()
                    .frame(height: 0)
                Text("No Internet Connection")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 15))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .frame(height: 20 , alignment: .center)
                    .background(Color.red)
            }
        }
    }
}

#Preview {
    PlantsListScreen()
}

struct PlantsListSell: View {
    @State var plant: UIPlant
    var onFavoriteTapAction: (UIPlant) -> ()
    var onDeleteTapAction: (Int) -> ()
    
    var body: some View {
        HStack {
            Spacer()
            if plant.image == "" {
                Image("plug_image")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .background(Color.gray)
                    .cornerRadius(15)
            } else {
                AsyncImage(url: URL(string: (plant.image!))) { image in
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
            }
            
            Spacer()
            VStack() {
                Spacer()
                Text(plant.name)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 20))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                Text("\(plant.id)")
                    .foregroundStyle(Color.gray)
                    .font(.system(size: 15))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            Spacer()
            Button(action: {
                if plant.isFavorite == true {
                    onDeleteTapAction(plant.id)
                }
                else {
                    onFavoriteTapAction(plant)
                }
            }) {
                Image(systemName: plant.isFavorite == true ? "heart.circle.fill" : "heart.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.horizontal, 8)
                    .foregroundStyle(plant.isFavorite == true ? Color.lightGreen : Color.white)
            }
            Spacer()
        }
        .frame(width: UIScreen.screenWidth - 40, height: 100 )
    }
}
