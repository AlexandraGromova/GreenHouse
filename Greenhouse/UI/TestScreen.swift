import Foundation
import SwiftUI

struct TestScreen: View {
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            List(1...10, id: \.self) { i in
                Text("Row \(i)")
                }
//            VStack {
//                TestButton(
//                    primaryButton: ExplandableButtonItem(label: Image(systemName: "heart")), secondaryButtons: [
//                        ExplandableButtonItem(label: Image(systemName: "heart.fill")) {
//                        }
//                        ,
//                        ExplandableButtonItem(label: Image(systemName: "heart.circle")){
//                        }
//                    ]
//                )
//                Spacer()
//            }
        }
    }
}

#Preview {
    MainScreen()
}
//
//
//
//
//struct TestButton: View {
//    @State private var isExplanded = false
//    
//    let primaryButton: ExplandableButtonItem
//    let secondaryButtons: [ExplandableButtonItem]
//    
//    var body: some View {
//        VStack {
//            if isExplanded {
//                ForEach(secondaryButtons) { button in
//                    Button(action: { button.action?()
//                    }, label: {
//                        Text(button.label)
//                    })
//                    .font(.system(size: 15))
//                    .foregroundStyle(Color.white)
//                    .frame(width: 90, height: 30)
//                    .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 10)))
//                }
//            }
//            Button(action: {
//                withAnimation {
//                    self.isExplanded.toggle()
//                }
//                self.primaryButton.action?()
//            }, label: {
//                Text(self.primaryButton.label)
//            })
//            .font(.system(size: 15))
//            .foregroundStyle(Color.white)
//            .frame(width: 90, height: 30)
//            .clipShape(RoundedRectangle(cornerSize: .init(width: 10, height: 10)))
//        }
//        .background(Color.lightGreen)
//        .cornerRadius(32)
//    }
//}
//
//struct ExplandableButtonItem: Identifiable {
//    var id = UUID()
//    let label: String
//    var action: (() -> Void)? = nil
//}
