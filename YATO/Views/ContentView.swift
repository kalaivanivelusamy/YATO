

import SwiftUI


struct ContentView: View {
    
    @FetchRequest(
        entity: Tasks.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Tasks.name, ascending: true),
        ]
    ) var allTasks: FetchedResults<Tasks>
    
    
    
    
    
    @State var addPage = false
    @State var isNewTask = false
    //@StateObject var tasksContainer = TasksModel()
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var businessCount: Int = 0
    
    var body: some View {
        
        VStack(spacing:20){
            
            HStack{    
                Text("Hey, What's up!")
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 20, leading:20, bottom: 0, trailing: 0))
                Spacer()
            }
            
            Text("Categories").font(.title3).foregroundColor(.gray).padding(EdgeInsets(top: 0, leading: -180, bottom: 0, trailing: 0))
            Spacer()
            
            HStack(spacing: 10)
              {
                  
                  CardView(isBusiness: true,cardText: "Business")
                  
                  CardView(isBusiness: false,cardText: "Personal")

              }.padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))
            
        NavigationView {
            List {
                ForEach(allTasks) { task in 
                    TaskRowView(taskRow: task)
                }
                .onDelete(perform: deleteTask)
//                .onTapGesture {
//                            print("tapped")
//                        }
            }
            .sheet(isPresented: $addPage) {
                AddTaskView(addPage: $addPage)
            }
            .navigationTitle("Today's tasks")
            .navigationBarItems(trailing:
                Button(action: { addPage.toggle() }){
                    Image(systemName: "plus")
                        .frame(width: 50, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                }
            )
        }
     }

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

