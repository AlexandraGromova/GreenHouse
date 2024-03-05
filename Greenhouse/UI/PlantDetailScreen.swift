import Foundation
import SwiftUI

struct PlantDetailScreen: View {
    
    let plant: UIPlant
    
    init(plant: UIPlant) {
        self.plant = plant
    }
    
    var body: some View {
        VStack {
            if plant.image == "" {
                Image("plug_image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 2)
                    .background(Color.lightGreen)
                    .clipShape(
                        .rect(
                            bottomLeadingRadius: 50,
                            bottomTrailingRadius: 50
                        )
                    )
            } else {
                AsyncImage(url: URL(string: (plant.image!))) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 2)
                        .background(Color.lightGreen)
                        .clipShape(
                            .rect(
                                bottomLeadingRadius: 50,
                                bottomTrailingRadius: 50
                            )
                        )
                } placeholder: {
                    ProgressView()
                }
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 2)
            }
            
            
            
            Text(plant.name)
                .foregroundStyle(Color.black)
                .font(.system(size: 40))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 25)
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MainScreen()
}
