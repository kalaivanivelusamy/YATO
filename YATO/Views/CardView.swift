
import SwiftUI


struct ProgressBar: View {
   
    @Binding var value: Float

    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading){
                Rectangle().frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemGray))
                
                ZStack(){
                    
                    Rectangle()
                        .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                            .foregroundColor(Color(UIColor.systemPink))
                            .animation(.linear)
                        .alignmentGuide(.trailing, computeValue: { dimension in
                            dimension[.trailing]
                        })
                        Rectangle()
                               .fill(Color.pink)
                               .frame(width:4, height:10)
                            .alignmentGuide(VerticalAlignment.top, computeValue: { dimension in
                                dimension[.bottom]
                            })
                        .animation(.linear)
                }
                
            }.cornerRadius(40)  
        }
    }
}

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
    
    
    @State var progressValue: Float = 0.0

    func startProgressBar() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { timer in
            withAnimation(){
                self.progressValue += 0.01
                if self.progressValue >= 0.6 {
                    timer.invalidate()
                } 
            }
        }
           
    }
    
   
    var body: some View {

        ZStack{
            
            Color.white
                .cornerRadius(25)
            
            VStack(alignment: .leading,spacing:10) {
            
                Text( isBusiness ? "\(businessTasks.count) tasks" : "\(personalTasks.count) tasks").foregroundColor(.gray)

            Text(cardText).font(.headline).foregroundColor(.black)
               
            ProgressBar(value:$progressValue).frame(height: 5)
                
            }.padding(.horizontal,5).padding(.bottom,15).frame(width: 200, height: 60)  
        }.frame(width: 250, height: 120)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 0)
        .onAppear(perform: {
            startProgressBar()
        })

    }
    
    
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(isBusiness: false, numOfTasks_business: )
//    }
//}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
