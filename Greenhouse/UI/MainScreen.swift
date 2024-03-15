import SwiftUI

struct MainScreen: View {
    
    @State var selectedPage = 2
    
//    var plant = UIPlant(id: 13, name: "GJi encnv", image: "")
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedPage) {
                FavoriteListScreen()
                    .tabItem {
                        Image(systemName: "suit.heart.fill")
                    }
                    .tag(1)
                PlantsListScreen()
                    .tabItem {
                        Image(systemName: "leaf.fill")
                    }
                    .tag(2)
            }
            .navigationTitle(selectedPage == 1 ? "Favorites" : "All Plants")
            .accentColor(Color.lightGreen)
        }
    }
}

#Preview {
    MainScreen()
}
