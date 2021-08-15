
import Foundation
import SwiftUI



class TasksModel: ObservableObject {
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @FetchRequest(
        entity: Tasks.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Tasks.name, ascending: true),
        ]
    ) var allTasks: FetchedResults<Tasks>
    
    
    
    init() {
        
    }
    
       
    }
    

