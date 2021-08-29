
import SwiftUI

struct TabButtonView: View {
    
    var image: String
    var title : String
    
    @Binding var selectedTab: String
    
    var animation: Namespace.ID
    
    var body: some View {
        
        Button(action: {
            withAnimation(.spring()){
                selectedTab = title
            }
        }, label: {
            HStack(spacing: 10) {
                Image(systemName: image)
                    .font(.title2)
                    .frame(width: 30)
                Text(title)
                    .fontWeight(.semibold)
            }
            .foregroundColor(selectedTab == title ? Color(.blue) : .white)
            .padding(.vertical,12)
            .padding(.horizontal,20)
            .background(
                
                //hero Animation
                ZStack {
                    if selectedTab == title {
                    Color.white
                        .opacity(selectedTab == title ? 1 : 0)
                        .clipShape(CustomCorner(corners: [.topRight,.bottomRight], radius: 12.0))
                        .matchedGeometryEffect(id: "TAB", in: animation)
                    }
                }
            )
           
        })
        
        
    }
}

struct TabButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
