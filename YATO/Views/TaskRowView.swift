
import SwiftUI

struct TaskRowView: View {
   // var taskRow: TasksModel
    let taskRow: Tasks
    @State var isDone = false
    
    var body: some View {
        HStack(spacing:10){
            Button(action:{
                    isDone.toggle()
            })
            {
                Image(systemName: isDone ? "checkmark.square" : "square")
                .resizable()
                .foregroundColor( isDone ? .gray : .blue)
            }
            .frame(width: 30, height: 30, alignment: .leading)
            getTitle().font(.title2).strikethrough(isDone).foregroundColor(isDone ? .gray : .black)  
            getDate().font(.title2).strikethrough(isDone).foregroundColor(isDone ? .gray : .black)            

        }
        
        .frame(maxWidth: .infinity,alignment: .leading)
        .frame(height:40)
        .padding(10)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray.opacity(0.2),lineWidth: 0.3))
        .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 0, y: 2)
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
    
    
}

//struct TaskRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskRowView(taskRow: TasksModel(name: "kv", date: Date()))
//    }
//}
