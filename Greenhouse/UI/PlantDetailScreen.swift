import Foundation
import Combine
import SwiftUI

struct PlantDetailScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
    }) {
        HStack(spacing: 0) {
            Image(systemName: "arrow.left.circle.fill")
                .resizable()
                .scaledToFill()
                .frame(height: 40)
                .foregroundColor(Color.darkGreen)
                .background(Circle().frame(height: 30).foregroundStyle(Color.white))
                .offset(x: -9)
        }
    }
    }
    
    var plantID: Int
    @StateObject var vm = AppContainer.resolve(PlantDetailsVM.self)
    @State var plant: UIPlant = UIPlant(id: 0, name: "", image: "")
    
    var body: some View {
        VStack(spacing: 0) {
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
                    .shadow(color: .black, radius: 15)
                PlantDetailsImage(image: plant.image ?? "")
            }
            ScrollView() {
                VStack(spacing: 0) {
                    Text(plant.name)
                        .font(Font.custom("ClashDisplayVariable-Bold_Light", size: 40))
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 25)
                        .padding(.top, 20)
                    
                    (Text(Image(systemName: "mappin.and.ellipse")) + (Text(plant.origin?.first ?? "" )))
                        .foregroundStyle(Color.lightGreen)
                        .font(.system(size: 20))
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 25)
                        .padding(.top, 4)
                    PlantSquareParams(plant: plant)
                        .padding(.vertical, 15)
                    PlantStraightParams(plant: plant)
                        .padding(.vertical, 5)
                    Spacer()
                        .frame(height: 50)
                }
            }
        }
        .ignoresSafeArea()
        .onAppear(){
            
            vm.getPlantDetails(id: plantID)
        }
        .onChange(of: vm.plantDetails) { newValue in
            plant = newValue
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: btnBack)
        
    }
}

struct PlantDetailsImage: View {
    var image: String
    var body: some View {
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
                .shadow(color: .black, radius: 15)
            AsyncImage(url: URL(string: image),
                       scale: 3) { phase in
                switch phase {
                case .empty:
                    HStack {
                        ProgressView()
                    }
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(let error):
                    Text(error.localizedDescription)
                @unknown default:
                    EmptyView()
                }
            }
                       .clipShape(
                        .rect(
                            bottomLeadingRadius: 45,
                            bottomTrailingRadius: 45
                        )
                       )
                       .frame(width: UIScreen.screenWidth - 40, height: UIScreen.screenHeight / 2 - 40)
                       .padding(.top, 30)
        }
    }
}

struct PlantStraightParams: View {
    var plant: UIPlant
    var body: some View {
        VStack (alignment: .leading, spacing: 2){
            StraightCell(name: "care level:", text: "\(plant.care_level ?? "")")
            StraightCell(name: "dimension:", text: "\(plant.dimension ?? "")")
            StraightCell(name: "medicinal:", text: "\(plant.medicinal ?? false)")
        }
        .foregroundStyle(Color.black)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 25)
    }
}

struct StraightCell: View {
    var name: String
    var text: String?
    var body: some View {
        HStack() {
            Text(name)
                .foregroundStyle(Color.darkGreen)
                .font(Font.custom("ClashDisplayVariable-Bold_Light", size: 23))
                .fontWeight(.regular)
            Text(text ?? "nil")
                .font(Font.custom("BoskaVariable-Extralight-Italic_Black-Italic", size: 24))
                .fontWeight(.bold)
        }
    }
}

struct PlantSquareParams: View {
    var plant: UIPlant
    var body: some View {
        HStack(spacing: 0) {
            SquareCell(text: plant.watering ?? "", image: Image(systemName: "drop.fill"))
            SquareCell(text: plant.sunlight?.first ?? "", image: Image(systemName: "sun.max.fill"))
            SquareCell(text: plant.cycle ?? "", image: Image(systemName: "arrow.triangle.2.circlepath"))
        }
    }
}

struct SquareCell: View {
    var text: String
    var image: Image
    var body: some View {
        HStack(spacing: 0) {
            VStack() {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 35)
                    .foregroundStyle(Color.lightGreen)
                Text(text)
                    .font(Font.custom("ClashDisplayVariable-Bold_Light", size: 15))
                    .fontWeight(.medium)
            }
        }
        .frame(width: 100, height: 100)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.lightGreen, lineWidth: 3)
        )
        .padding(.horizontal, 10)
    }
}



#Preview {
    MainScreen()
}
