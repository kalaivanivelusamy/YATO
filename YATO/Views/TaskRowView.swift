
import SwiftUI

struct TaskRowView: View {

   @ObservedObject var taskRow: Tasks
    
    @State var isDone = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Binding var totalTasksFinished: Float
    
    var body: some View {
        
        HStack(spacing:10){
            
            Button(action:{
                isDone.toggle()
                totalTasksFinished = isDone ? (totalTasksFinished + 1) : (totalTasksFinished - 1)
            })
            {
                Image(systemName: isDone ? "checkmark.circle" : "circle")
                .resizable()
                .foregroundColor( isDone ? .gray : (taskRow.isBusiness ? .blue : .pink))
            }
            .buttonStyle(PlainButtonStyle())
            .frame(width: 25, height: 25, alignment: .leading)
           
            getTitle().strikethrough(isDone)
                .foregroundColor(isDone ? Color(.secondaryLabel) : Color(UIColor.label))
                .padding(10)
                .onTapGesture {
                    getTitle()
            }

        }
        
        .frame(maxWidth: .infinity,alignment: .leading)
                .frame(height:30)
        .padding(10)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.systemGray).opacity(0.2),lineWidth: 0.3))
        .shadow(color: Color(UIColor.systemGray).opacity(0.2), radius: 5, x: 0, y: 2)
        
    }
    
    func didDismiss() {
            // Handle the dismissing action.
        }
    
    func getTitle() -> Text {
        if let text = taskRow.name.map(Text.init){
            return text
        }
        return Text("")
    }
    
    func getDate() -> Text {
        if let date = taskRow.date {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
            return Text(formatter.string(from: date))
        } else{
            return Text("")
        }
        
    }
    
    func finishTask(){
        
    }
    
    
}

//struct TaskRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskRowView(taskRow: TasksModel(name: "kv", date: Date()))
//    }
//}
