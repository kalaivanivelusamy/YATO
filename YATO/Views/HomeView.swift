

import SwiftUI
import GoogleSignIn


struct PersonalInfoView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel

    private let user = GIDSignIn.sharedInstance().currentUser
    @Binding var showMenu: Bool 

    
    var body: some View {
        
        HStack {

        NetworkImage(url: user?.profile.imageURL(withDimension: 200))
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(8)

          VStack(alignment: .leading) {
            Text(user?.profile.name ?? "")
              .font(.headline)

            Text(user?.profile.email ?? "")
              .font(.subheadline)
          }

        Spacer()
            
        Button("Sign out") {
              viewModel.signOut()
            }
            .buttonStyle(AuthenticationButtonStyle()).opacity(0.0)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemFill))
        .cornerRadius(12)
        .padding()
    }
}

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
      @State var showMenu = false

      var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -150 {
                    withAnimation {
                        showMenu.toggle()
                        }
                    }
            }
        
       // return NavigationView {
        
        VStack (alignment: .leading) {
            
            Button(action: { withAnimation {
                        self.showMenu.toggle()}})
                        {
                            Image(systemName:"line.horizontal.3")
                            .imageScale(.large)
                                .frame(width:40,height: 40)
                        }
            .padding(.leading,20)
            .padding(.top,30)
      
            GeometryReader { geometry in
                        
                ZStack(alignment: .leading) {
                    VStack(alignment: .leading, spacing: 20) {
                        CenterView()
                        }
//                    MenuView()
//                        .frame(width:geometry.size.width-100,height: geometry.size.height).edgesIgnoringSafeArea(.all)
//                    .opacity(showMenu ? 1 : 0)
//                    .transition(.slide)
//                    .animation(.easeInOut)
//                    .gesture(drag)
                    //to hide the opened side menu
                }
        }
        }
        .fullScreenCover(isPresented: $showMenu, content: {
            MenuView()
            .edgesIgnoringSafeArea(.all)
            .frame(width: 350)
            .transition(.slide) 
            //.opacity(showMenu ? 1 : 0)
            .animation(Animation.interactiveSpring())
            .gesture(drag)
            //to hide the opened side menu
        })             
      
      } 
}


struct NetworkImage: View {
  let url: URL?

  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image(systemName: "person.circle.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
