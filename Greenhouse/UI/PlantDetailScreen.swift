import Foundation
import SwiftUI

struct PlantDetailScreen: View {
    
    let plant: UIPlant
    
    init(plant: UIPlant) {
        self.plant = plant
    }
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.lightGreen)
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 2)
                    .clipShape(
                        .rect(
                            bottomLeadingRadius: 50,
                            bottomTrailingRadius: 50
                        )
                    )
                
                if plant.image == "" {
                    Image("plug_image")
                        .resizable()
                        .scaledToFit()
                        .frame(width: .infinity)
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
                            .clipShape(
                                .rect(
                                    bottomLeadingRadius: 45,
                                    bottomTrailingRadius: 45
                                )
                            )
                            .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenHeight / 2 - 40)
                        
                    } placeholder: {
                        ProgressView()
                    }
                }
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
