
import SwiftUI

struct CardView: View {
    @State var noOfTasks: Double = 2
    @State var isBusiness: Bool
    @State var cardText = ""
    @State var scale: CGFloat = 1

    // For both personal and business tasks same binding
    @Binding var totalTasksFinished: Float

    
    @FetchRequest(
        entity: Tasks.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Tasks.name, ascending: true),
        ],
        predicate: NSPredicate(format: "isBusiness == true")
    ) var businessTasks: FetchedResults<Tasks>
    
    
    @FetchRequest(
        entity: Tasks.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Tasks.name, ascending: true),
        ],
        predicate: NSPredicate(format: "isBusiness == false")
    )  var personalTasks: FetchedResults<Tasks>
    
    

    
    var body: some View {
        
        ZStack{
            
            Color.white
                .cornerRadius(25)
            
            VStack(alignment: .leading,spacing:10) {
            Text( isBusiness ? "\(businessTasks.count) tasks" : "\(personalTasks.count) tasks").foregroundColor(.gray)

            Text(cardText).font(.headline).foregroundColor(.black)

            
               // if totalTasksFinished > 0.0 {
                    createSlider()
               // }
                
            }.padding(.horizontal,5).padding(.bottom,15).frame(width: 200, height: 60)  
        }.frame(width: 250, height: 120)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)

    }
    
    func createSlider() -> some View {
        let count = Float(isBusiness ? businessTasks.count : personalTasks.count)
       
//        return Slider(value: $totalTasksFinished, in: 0...count, step: 1.0)
//        .accentColor(isBusiness ? .blue : .pink)
        
       return //GeometryReader { geometry in
                    ZStack {
                        //HStack{
                        Rectangle().frame(width: 200, height: 10)
                            .opacity(1.0)
                            .foregroundColor(Color(UIColor.systemBlue))
                        
                        Rectangle().frame(width:20, height:20).background(Color.black).scaleEffect(scale)
                            .onAppear {
                                let baseAnimation = Animation.easeInOut(duration: 1)
                                let repeated = baseAnimation.repeatForever(autoreverses: true)

                                withAnimation(repeated) {
                                    scale = 0.5
                                }
                            }

                        //}
                    }.cornerRadius(45.0)
                //}
        
       
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(isBusiness: false, numOfTasks_business: )
//    }
//}
