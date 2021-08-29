import SwiftUI
import Charts
import GoogleSignIn

struct MenuView: View {
    
    private let user = GIDSignIn.sharedInstance().currentUser
//    let data = [0.7,0.1,0.3,0.5,0.6]
//    @State private var completionAmount: CGFloat = 0.0
//
//    let timer = Timer.publish(every:0.45, on: .main, in: .common).autoconnect()

    @Binding var showMenu: Bool
    @Binding var selectedTab: String
    
    @Namespace  var animation

    
    var body: some View {
        
        ZStack{

            VStack(alignment: .leading,spacing:10) {
                
            Button(action: {
                    withAnimation(.spring()){
                    showMenu.toggle()
                    }
                    }){
                    Image(systemName: "chevron.left") 
                        .imageScale(.small)
                        .foregroundColor(Color.white)
                        .frame(width:40,height: 40)
            }
            .overlay(Circle().stroke(Color(UIColor.gray)))
            .offset(x: getRect().width - 160)
            .padding(.top,100)

            NetworkImage(url: user?.profile.imageURL(withDimension: 200))
                        .frame(width: 100, height: 100, alignment: .center)
                .clipShape(Circle()).padding()
                        
            Text(user?.profile.name ?? "")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(.white)
               
            //Tab buttons
                VStack(alignment: .leading,spacing: 10) {
                
                TabButtonView(image: "house", title: "Home", selectedTab: $selectedTab, animation: animation)
                
                TabButtonView(image: "gearshape.fill", title: "Settings", selectedTab: $selectedTab, animation: animation)
                
                TabButtonView(image: "clock.arrow.circlepath", title: "History", selectedTab: $selectedTab, animation: animation)
                    
                TabButtonView(image: "questionmark.circle", title: "Help", selectedTab: $selectedTab, animation: animation)
            }
            .padding(.leading,-15)
            .padding(.top,20)
                
            Spacer().frame(height:getRect().height*0.25)
                
            VStack(alignment: .leading, spacing: 6){
                
                TabButtonView(image: "rectangle.righthalf.inset.fill.arrow.right", title: "Sign out", selectedTab:.constant(""), animation: animation)
                    .padding(.leading,-15)
                Text("App Version: 1.0.0")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .opacity(0.6)
                    //.padding(.leading,20)
                } 
            }            
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity, alignment: .topLeading)
        .background(Color(#colorLiteral(red: 0.04327090085, green: 0.1375527084, blue: 0.3708509803, alpha: 1)))
        .ignoresSafeArea()

    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
