import Foundation
import SwiftUI

struct TestScreen: View {
    
    @State private var didLongPress: Bool = false
    @State private var height: CGFloat = 100
    @State private var width: CGFloat = 100
    
    var body: some View {
        Image("plug_image")
            .resizable()
            .frame(width: width, height: height)
            .animation(.default)
            .background(Color.gray)
            .cornerRadius(15)
        
            .gesture(
                LongPressGesture()
                    .onEnded({ _ in
                        if self.didLongPress == false {
                            self.width = 150
                            self.height  = 150
                        } else if self.didLongPress == true {
                            self.width = 100
                            self.height  = 100
                        }
                        self.didLongPress.toggle()
                    }))
    }
}
