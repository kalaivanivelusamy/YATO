//
//  CardView.swift
//  YATO
//
//  Created by V, Kalaivani V. (623-Extern) on 15/08/21.
//

import SwiftUI

struct CardView: View {
    @State var noOfTasks: Double = 2
    @State var isBusiness: Bool
    @State var cardText = ""
//    @Binding var numOfTasks_business: Int 
//    @State var numOfTasks_personal: Int = 0

    //@ObservedObject var businessTasks : Tasks
    
    @FetchRequest(
        entity: Tasks.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Tasks.name, ascending: true),
        ],
        predicate: NSPredicate(format: "isBusiness == true")
    ) var businessTasks: FetchedResults<Tasks>
    
    
    @FetchRequest(
        entity: Tasks.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Tasks.name, ascending: true),
        ],
        predicate: NSPredicate(format: "isBusiness == false")
    )  var personalTasks: FetchedResults<Tasks>
    
    var body: some View {
        
        ZStack{
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .shadow(radius: 10)
            
            VStack(alignment: .center,spacing:20) {
                
            Text("\(businessTasks.count) tasks").foregroundColor(.gray).hideView(!isBusiness)
            Text("\(personalTasks.count) tasks").foregroundColor(.gray).hideView(isBusiness)
                
            Text(cardText).font(.headline).foregroundColor(.black)
                
            Slider(value: $noOfTasks, in: 0...10)
                .padding(20)
                .accentColor(isBusiness ? .blue : .pink)
            }.padding()
        
        }.frame(width: 200, height: 100)
        
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView(isBusiness: false, numOfTasks_business: )
//    }
//}
