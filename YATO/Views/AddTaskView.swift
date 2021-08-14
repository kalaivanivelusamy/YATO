

import SwiftUI

struct AddTaskView: View {
    
    @State var newTask = ""
    @Binding var addPage: Bool
    @State var isBusinessTask = true
    @State var taskdate = Date()
    @State var showDate = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    

    var body: some View {
        
        NavigationView {
            
            LazyVStack(alignment: .leading, spacing: 70) {
                HStack{
                    Spacer().frame(maxWidth: .infinity)
                    Button(action: {
                        addPage.toggle()
                    }){
                Image(systemName: "multiply")
                    .frame(width: 40, height: 40)
                    .foregroundColor(.black)
                    .overlay(Circle().stroke(Color.gray,lineWidth: 1))
                    }
                    .padding(.trailing,40)
                }
                
            TextField("Add New Task", text: $newTask)
                .padding(30)
                
                //calendar
                DatePicker(
                    "", selection: $taskdate, displayedComponents: .date)
                    .labelsHidden()
                    .frame(alignment: .center)
                    .hideView(!showDate)
                
            HStack (spacing: 20) {
                //calendar button
                Button(action: {
                    print("calendar is clicked")
                    showDate.toggle()
                }){
                    HStack(alignment: .center, spacing: 0){
                    Image(systemName: "calendar")
                        .foregroundColor(.gray)
                    Text("Today").frame( alignment: .center).foregroundColor(.gray)
                    }
                }
                .frame(width: 100, height: 40)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray,lineWidth: 1.0))
                .padding()
                
                //category button
                
                Button(action: {
                    isBusinessTask.toggle()
                    print("Category is clicked \(isBusinessTask ? "Business" : "Personal")")

                }){
                    ZStack {
                        Circle()
                            .fill(Color.white)
                        Circle()
                            .fill(isBusinessTask ? Color.blue : Color.pink).frame(width: 12, height: 12)
                        Circle()
                            .strokeBorder(isBusinessTask ? Color.blue : Color.pink, lineWidth: 2)
                    }
                    .frame(width: 20, height: 20)

                }
                .frame(width: 35, height: 35)
                .overlay(Circle().stroke(Color.gray,lineWidth: 1))
            }
                
            Button(action: {
                addTask()
                addPage.toggle()
            }){
                HStack(alignment: .center, spacing: 5){
                    Text("Add task")
                    Image(systemName: "chevron.up")
                }
            }
            .buttonStyle(GradientStyleButton())
            .padding(EdgeInsets(top: 0, leading: 250, bottom: 0, trailing: 10))

        //}
    }
        }
       // .opacity(addPage ? 1 : 0).animation(.easeOut(duration: 3.0))
    }
    
    func addTask() {
        
        let newTaskObj = Tasks(context: managedObjectContext)
        newTaskObj.name = newTask
        newTaskObj.date = taskdate
        newTaskObj.isFinished = false
        newTaskObj.id = UUID()
        
        PersistenceController.shared.save()
    }
    
    func editTask() {
        let newTaskObj = Tasks(context: managedObjectContext)
        newTaskObj.name = newTask
        PersistenceController.shared.save()
    }
    
   
}

struct AddTaskView_Previews: PreviewProvider {
     @State static var addPage: Bool = true

    static var previews: some View {
        AddTaskView(addPage: $addPage)
    }
}

struct GradientStyleButton: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(20.0)
            .shadow(color: .blue, radius: 3, x: 0, y: 1)
            
    }
    
    
}

extension View {
    func hideView(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
}
