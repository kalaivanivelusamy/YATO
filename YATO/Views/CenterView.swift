

import SwiftUI
import GoogleSignIn
import CoreData

extension CenterView{
    
//    public func getPredicate() -> NSCompoundPredicate {
//        
//        var calendar = Calendar.current
//        calendar.timeZone = NSTimeZone.local
//        let dateFrom = calendar.startOfDay(for: Date()) 
//        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
//        let fromPredicate = NSPredicate(format: "%@ >= %K", dateFrom as NSDate, #keyPath(Tasks.date))
//        let toPredicate = NSPredicate(format: "%K < %@", #keyPath(Tasks.date), dateTo as! NSDate)
//        let datePredicate = NSCompoundPredicate(type: .and, subpredicates: [fromPredicate,toPredicate])      
//        self.dateFetchRequest.predicate = datePredicate
//       
//        return datePredicate
//    }
    
    
    static var dueSoonFetchRequest: NSFetchRequest<Tasks> {
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        let dateFrom = calendar.startOfDay(for: Date()) 
        let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom)
        let fromPredicate = NSPredicate(format: "%@ >= %K", dateFrom as NSDate, #keyPath(Tasks.date))
        let toPredicate = NSPredicate(format: "%K <= %@", #keyPath(Tasks.date), dateTo! as NSDate)
        let datePredicate = NSCompoundPredicate(type: .and, subpredicates: [fromPredicate,toPredicate])      
        
        let request: NSFetchRequest<Tasks> = Tasks.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        request.predicate = datePredicate
        return request
      }
}

struct CenterView: View {
    
    @State var totalBusinessTasksFinished: Float = 0.0
    @State var totalPersonalTasksFinished: Float = 0.0
    @State private var isPresented = false
    
    private let user = GIDSignIn.sharedInstance().currentUser

    
    @FetchRequest(fetchRequest: CenterView.dueSoonFetchRequest)
    var allTasks: FetchedResults<Tasks>
    
//    @FetchRequest(
//               entity: Tasks.entity(),
//               sortDescriptors: [
//                   NSSortDescriptor(keyPath: \Tasks.name, ascending: true),
//               ]
//           )  var allTasks: FetchedResults<Tasks>
    


    @Environment(\.managedObjectContext) var managedObjectContext
    
//    init() {
//        @FetchRequest(
//            entity: Tasks.entity(),
//            sortDescriptors: [
//                NSSortDescriptor(keyPath: \Tasks.name, ascending: true),
//            ]
//        )  var allTasks: FetchedResults<Tasks>
//    }
    
   
    var body: some View {
              
        VStack(alignment: .leading, spacing:0){
            
            HStack(){    
                Text("What's up! \(user?.profile.name ?? "")")
                    .font(.largeTitle)
                    .bold()
                    .padding(EdgeInsets(top: 20, leading:25, bottom: 0, trailing: 0))
                }
            Spacer()
            
            Text("Categories").font(.caption).foregroundColor(.gray).padding(.horizontal, 25)
                    
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20) {
                    CardView(isBusiness: true,cardText: "Business",totalTasksFinished:$totalBusinessTasksFinished)
                    CardView(isBusiness: false,cardText: "Personal",totalTasksFinished: $totalPersonalTasksFinished)
                    CardView(isBusiness: false,cardText: "Finance",totalTasksFinished: $totalPersonalTasksFinished)
                    }
                    .padding()
                }
            Spacer()
            
            Text("Today's tasks").font(.title3).foregroundColor(Color(UIColor.systemGray)).padding(.horizontal, 25)
            ZStack(alignment: .bottomTrailing) {
            
            List {
                    ForEach(allTasks) { task in 
                        TaskRowView(taskRow: task,totalTasksFinished: task.isBusiness ? $totalBusinessTasksFinished : $totalPersonalTasksFinished)
                }
                .onDelete(perform: deleteTask)
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
       // .background(Color(#colorLiteral(red: 0.9801443219, green: 0.9841703773, blue: 0.9964856505, alpha: 1)))
        .background(Color(UIColor.systemBackground))
        .fullScreenCover(isPresented: $isPresented, content: {
            AddTaskView(addPage: $isPresented)
        })
    }
    
    func deleteTask(at offsets: IndexSet) {
        withAnimation {
            managedObjectContext.perform {
                offsets.forEach { index in
                    let task = self.allTasks[index]
                    self.managedObjectContext.delete(task)
                }
                PersistenceController.shared.save()
            }
        }
    }
}

struct CenterView_Previews: PreviewProvider {
    static var previews: some View {
        CenterView()
    }
}
