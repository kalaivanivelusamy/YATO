

import SwiftUI

import GoogleSignIn


struct ContentView: View {
    

    @EnvironmentObject var viewModel: AuthenticationViewModel

    @FetchRequest(
        entity: Tasks.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Tasks.name, ascending: true),
        ]
    ) var allTasks: FetchedResults<Tasks>
    
    
    @State var addPage = false
    @State var isNewTask = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var totalBusinessTasksFinished: Float = 0.0
    @State var totalPersonalTasksFinished: Float = 0.0

    var body: some View {
        
        switch viewModel.state {
            case .signedIn:
                HomeView()
            default:
                LoginView()
        }
        
//        VStack(spacing:20){
//            
//            HStack{    
//                Text("Hey, What's up!")
//                    .font(.largeTitle)
//                    .padding(EdgeInsets(top: 20, leading:20, bottom: 0, trailing: 0))
//            }
//            
//            Text("Categories").font(.title3).foregroundColor(.black).padding(.horizontal, 10)
//            
//            ScrollView(.horizontal, showsIndicators: false){
//            HStack(spacing: 30) {
//                CardView(isBusiness: true,cardText: "Business",totalTasksFinished: $totalBusinessTasksFinished)
//                CardView(isBusiness: false,cardText: "Personal",totalTasksFinished: $totalPersonalTasksFinished)
//                  CardView(isBusiness: false,cardText: "Finance",totalTasksFinished: $totalPersonalTasksFinished)
//
//            }
//            .padding()
//        }
//        
//
//        NavigationView {
//            List {
//                ForEach(allTasks) { task in 
//                    TaskRowView(taskRow: task,totalTasksFinished: task.isBusiness ? $totalBusinessTasksFinished : $totalPersonalTasksFinished)
//                }
//                .onDelete(perform: deleteTask)
////                .onTapGesture {
////                            print("tapped")
////                        }
//            }.background(Color(UIColor.clear))
//            .sheet(isPresented: $addPage) {
//                AddTaskView(addPage: $addPage)
//            }
//            .navigationTitle("Today's tasks")
//            .navigationBarItems(trailing:
//                Button(action: { addPage.toggle() }){
//                    Image(systemName: "plus")
//                        .frame(width: 50, height: 50)
//                        .background(Color.blue)
//                        .foregroundColor(Color.white)
//                        .clipShape(Circle())
//                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
//                }
//            )
//        }.background(Color(UIColor.clear))
//    }.background(Color(UIColor.lightGray))

        }
    
    
    
    func deleteTask(at offsets: IndexSet) {
        
        offsets.forEach { index in
            let task = self.allTasks[index]
            self.managedObjectContext.delete(task)
            PersistenceController.shared.save()
        }
    }
    
   
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(per)
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
