
import Foundation
import SwiftUI

struct TasksModel: Identifiable,Hashable {
    let id:UUID = UUID()
    let name: String
    let date: Date
}

class TasksContainer: ObservableObject {
    @Published var tasks: [TasksModel]
    @Environment(\.managedObjectContext) var managedObjectContext
    

    init() {
        
        self.tasks = [
        TasksModel(name: "first",date: Date()),
        TasksModel(name: "second",date: Date()),
        TasksModel(name: "third",date: Date()),
        TasksModel(name: "fourth",date: Date())
        ]
        
       
       

       
       
    }
    
    
}
