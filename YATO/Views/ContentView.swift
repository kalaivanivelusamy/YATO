

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
        
    }
    
    
    func deleteTask(at offsets: IndexSet) {
        
        offsets.forEach { index in
            let task = self.allTasks[index]
            self.managedObjectContext.delete(task)
            PersistenceController.shared.save()
        }
    }
    
   
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
