import SwiftUI

struct FavoriteListScreen: View {
    
    @StateObject var vm = AppContainer.resolve(FavoriteListVM.self)
    
    private var columns: [GridItem] = [
        GridItem(.fixed(UIScreen.screenWidth / 2 - 40), spacing: 20),
        GridItem(.fixed(UIScreen.screenWidth / 2 - 40), spacing: 20)
    ]
    
    var body: some View {
        VStack() {
            ScrollView(showsIndicators: false) {
                LazyVGrid(
                    columns: columns,
                    alignment: .center,
                    spacing: 16,
                    pinnedViews: [.sectionHeaders, .sectionFooters]
                ) {
                    Section() {
                        ForEach(Array(vm.plants.enumerated()), id: \.element) { index, plant in
                            NavigationLink(destination: PlantDetailScreen(plant: plant)) {
                                FavoriteListCell(plant: plant) { _ in
                                    vm.deletePlant(plantID: plant.id)
                                }
                                .transition(.slide)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct FavoriteListCell: View {
    
    @State var isLongPress = false
    var plant: UIPlant
    var onTapDeletePlant: (Int) -> ()
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                VStack {
                    if plant.image == ""  {
                        Image("plug_image")
                            .resizable()
                            .foregroundStyle(Color.black.opacity(isLongPress ? 0.5 : 0))
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .background(Color.gray)
                            .foregroundStyle(Color.black.opacity(isLongPress ? 0.5 : 0))
                            .cornerRadius(15)
                    } else {
                        AsyncImage(url: URL(string: (plant.image)!)) { image in
                            image
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundStyle(Color.black.opacity(isLongPress ? 0.5 : 0))
                                .background(Color.gray)
                                .cornerRadius(15)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 100, height: 100)
                        .background(Color.gray)
                        .cornerRadius(15)
                    }
                }
                .gesture(
                    LongPressGesture()
                        .onEnded({ _ in
                            self.isLongPress.toggle()
                        }))
                
                Text(plant.name)
                    .foregroundStyle(isLongPress ? Color.black.opacity(0.2) : Color.gray)
                    .foregroundStyle(Color.white)
                    .font(.system(size: 20))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                
                Text("\(plant.id)")
                    .foregroundStyle(isLongPress ? Color.black.opacity(0.2) : Color.gray)
                    .font(.system(size: 15))
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                Spacer()
            }
            if isLongPress {
                VStack {
                    Spacer()
                        .frame(height: 40)
                    Button(action: {
                        onTapDeletePlant(plant.id)
                    }) {
                        Image(systemName: "trash.circle.fill")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(Color.black)
                            .background(Color.gray)
                            .clipShape(Circle())
                    }
                    Spacer()
                }
            }
        }
        .frame(height: 185)
        .background(Color.black.opacity(isLongPress ? 0.5 : 0))
        .background(Color.lightGray)
        .cornerRadius(15)
    }
}





#Preview {
    FavoriteListScreen()
}
