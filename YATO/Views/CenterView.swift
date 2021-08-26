

import SwiftUI

struct CenterView: View {
    
    @State var totalBusinessTasksFinished: Float = 0.0
    @State var totalPersonalTasksFinished: Float = 0.0
    @State private var isPresented = false
    
    @FetchRequest(
        entity: Tasks.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Tasks.name, ascending: true),
        ]
    ) var allTasks: FetchedResults<Tasks>

    @Environment(\.managedObjectContext) var managedObjectContext

    
    var body: some View {
              
        VStack(spacing:20){
            
            HStack{    
                
                Text("Hey, What's up!")
                    .font(.largeTitle)
                    .padding(EdgeInsets(top: 20, leading:20, bottom: 0, trailing: 0))
                }
            
            Text("Categories").font(.title3).foregroundColor(.black).padding(.horizontal, 10)
                    
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 30) {
                    CardView(isBusiness: true,cardText: "Business",totalTasksFinished:$totalBusinessTasksFinished)
                    CardView(isBusiness: false,cardText: "Personal",totalTasksFinished: $totalPersonalTasksFinished)
                    CardView(isBusiness: false,cardText: "Finance",totalTasksFinished: $totalPersonalTasksFinished)
        
                    }
                    .padding()
                }
            Spacer()
            
            ZStack(alignment: .bottomTrailing) {
            
            List {
                    ForEach(allTasks) { task in 
                        TaskRowView(taskRow: task,totalTasksFinished: task.isBusiness ? $totalBusinessTasksFinished : $totalPersonalTasksFinished)
                    }
                    .onDelete(perform: { indexSet in
                        deleteTask(at: indexSet)
                    })
            }
            

            Button(action: {
                    print("clicked")
                isPresented.toggle()
                }) {
                    Image(systemName: "plus")
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .clipShape(Circle())
                    .padding(10)
                    .offset(x:-10,y: -25)
                }
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            AddTaskView(addPage: $isPresented)
        })
    }
    
    
    
    func deleteTask(at offsets: IndexSet) {
        
        offsets.forEach { index in
            let task = self.allTasks[index]
            self.managedObjectContext.delete(task)
            PersistenceController.shared.save()
        }
    }
}

struct CenterView_Previews: PreviewProvider {
    static var previews: some View {
        CenterView()
    }
}
