import SwiftUI
import Combine

struct PlantsListScreen: View {
    
    @StateObject var vm = AppContainer.resolve(PlantsListVM.self)
    
    @State var isSearchMode = false
    @State var searchParams: SearchParameters = SearchParameters(watering: "", sunlight: "")
    
    var body: some View {
        ZStack() {
            VStack() {
                Spacer().frame(height: 40)
                ScrollView(showsIndicators: false) {
                    LazyVStack {
                        ForEach(Array(vm.plants.enumerated()), id: \.element) { index, plant in
                            NavigationLink {
                                PlantDetailScreen(plantID: plant.id)
                            } label: {
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
                                        if isSearchMode {
                                            vm.getSearchPlants(watering: searchParams.watering, sunlight: searchParams.sunlight)
                                        } else { vm.tryUpdatePlants()}
                                    }
                                }
                            }
                        }
                    }
                }
                if vm.error != nil {
                    Spacer()
                        .frame(height: 0)
                    Text("\(vm.error?.rawValue ?? "")")
                        .foregroundStyle(Color.white)
                        .font(.system(size: 15))
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 20 , alignment: .center)
                        .background(Color.red)
                }
            }
            VStack() {
                Spacer()
                    .frame(height: 0)
                SearchBarView(params: $vm.searchParams) { params in
                    searchParams.sunlight = params.sunlight
                    searchParams.watering = params.watering
                    vm.isSearchMode = true
                    isSearchMode = true
                }
                Spacer()
                
            }
        }
    }
}
#Preview {
    PlantsListScreen()
}

struct PlantsListSell: View {
    @State var plant: UIPlant
    @State private var scale = 1.0
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
                AsyncImage(url: URL(string: (plant.image ?? "https://perenual.com/storage/species_image/714_alocasia_low_rider/small/8415446715_799e70b503_b.jpg"))) { image in
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
                Text(plant.name.capitalizeFirstLetter().replacingOccurrences(of: "-", with: " "))
                    .foregroundStyle(Color.white)
                    .font(.system(size: 20))
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            Spacer()
            Button(action: {
                if plant.isFavorite == true {
                    scale += 0.2
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                        scale -= 0.2
                    }
                    onDeleteTapAction(plant.id)
                }
                else {
                    scale += 0.2
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                        scale -= 0.2
                    }
                    onFavoriteTapAction(plant)
                }
            }) {
                Image(systemName: plant.isFavorite == true ? "heart.circle.fill" : "heart.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding(.horizontal, 8)
                    .foregroundStyle(plant.isFavorite == true ? Color.lightGreen : Color.white)
                    .scaleEffect(scale)
                    .animation(.bouncy, value: scale)
            }
            Spacer()
        }
        .frame(width: UIScreen.screenWidth - 40, height: 100 )
    }
}

struct SearchBarView: View {
    @Binding var params: SearchParameters
    var onSearchTapAction: (SearchParameters) -> ()
    
    @State var sunlightNameAPIform = ""
    @State var sunlightNameUI = "all"
    
    @State var wateringNameAPIform = ""
    @State var wateringNameUI = "all"
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Spacer()
            Image(systemName: "sun.min.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.lightGreen)
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
            
            ParametersButton(
                primaryButton: ExplandableButtonItem(label: sunlightNameUI),
                secondaryButtons: [
                    ExplandableButtonItem(label: "full shade") {
                        sunlightNameAPIform = "full_shade"
                        sunlightNameUI = "full shade"
                    },
                    ExplandableButtonItem(label: "part shade") {
                        sunlightNameAPIform = "part_shade"
                        sunlightNameUI = "part shade"
                    },
                    ExplandableButtonItem(label: "sun part shade") {
                        sunlightNameAPIform = "sun-part_shade"
                        sunlightNameUI = "sun part shade"
                    },
                    ExplandableButtonItem(label: "full sun") {
                        sunlightNameAPIform = "full_sun"
                        sunlightNameUI = "full sun"
                    },
                    ExplandableButtonItem(label: "all") {
                        sunlightNameAPIform = ""
                        sunlightNameUI = "all"
                    }
                ]
            )
            
            Spacer()
            Image(systemName: "drop.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(width: 25, height: 25)
                .foregroundStyle(Color.lightGreen)
                .padding(.vertical, 4)
                .padding(.horizontal, 10)
            ParametersButton(
                primaryButton: ExplandableButtonItem(label: wateringNameUI),
                secondaryButtons: [
                    ExplandableButtonItem(label: "frequent") {
                        wateringNameAPIform = "frequent"
                        wateringNameUI = "frequent"
                    },
                    ExplandableButtonItem(label: "average") {
                        wateringNameAPIform = "average"
                        wateringNameUI = "average"
                    },
                    ExplandableButtonItem(label: "minimum") {
                        wateringNameAPIform = "minimum"
                        wateringNameUI = "minimum"
                    },
                    ExplandableButtonItem(label: "all") {
                        wateringNameAPIform = ""
                        wateringNameUI = "all"
                    }
                ]
            )
            Spacer()
            Button(action: {
                params = SearchParameters(watering: wateringNameAPIform, sunlight: sunlightNameAPIform)
                onSearchTapAction(params)
            }, label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 30, height: 30)
            })
            Spacer()
        }
    }
}

struct ParametersButton: View {
    @State private var isExplanded = false
    
    let primaryButton: ExplandableButtonItem
    let secondaryButtons: [ExplandableButtonItem]
    
    var body: some View {
        VStack {
            if isExplanded {
                ForEach(secondaryButtons) { button in
                    Button(action: {
                        button.action?()
                        withAnimation {
                            isExplanded.toggle()
                        }
                    }, label: {
                        Text(button.label)
                    })
                    .font(.system(size: 15))
                    .foregroundStyle(Color.white)
                    .frame(width: 90, height: 20)
                }
            }
            Button(action: {
                withAnimation {
                    self.isExplanded.toggle()
                }
                self.primaryButton.action?()
            }, label: {
                Text(self.primaryButton.label)
            })
            .font(.system(size: 15).bold())
            .foregroundStyle(Color.white)
            .frame(width: 100, height: 30)
            .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 10)))
        }
        .background(Color.lightGreen)
        .cornerRadius(15)
    }
}

struct ExplandableButtonItem: Identifiable {
    var id = UUID()
    let label: String
    var action: (() -> Void)? = nil
}

struct SearchParameters {
    var watering: String
    var sunlight: String
}

