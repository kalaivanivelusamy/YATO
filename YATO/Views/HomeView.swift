

import SwiftUI
import GoogleSignIn


struct PersonalInfoView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel

    private let user = GIDSignIn.sharedInstance().currentUser
    @Binding var showMenu: Bool 

//    func getRect() {
//        UIScreen.main.bounds.width
//    }
    
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

    @State var selectedTab = "Home"

      var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -150 {
                    withAnimation {
                        showMenu.toggle()
                        }
                    }
            }
        
   
        ZStack{
            
            MenuView(showMenu: $showMenu, selectedTab: $selectedTab).gesture(drag)
            
                ZStack(alignment: .leading) {
                    Color.white
                    .opacity(0.5)
                    .cornerRadius(showMenu ? 15.0 : 0)
                    .offset(x: showMenu ? -20 : 0)
                    .padding(.vertical,30)
                        
                    CenterView()
                    .cornerRadius(showMenu ? 15.0 : 0)
                }
               .scaleEffect(showMenu ? 0.84 : 1)
                .offset(x: showMenu ? CGFloat(UIScreen.main.bounds.width)-130: 0)
                .ignoresSafeArea()
                .overlay(
                    Button(action: {
                        withAnimation(.spring()){
                        showMenu.toggle()
                        }
                        }){
                        Image(systemName:"line.horizontal.3") 
                            .imageScale(.large)
                            .frame(width:80,height: 80)
                    }.padding(15).opacity(showMenu ? 0 : 1),alignment:.topLeading)
        }

           // }
        //}.ignoresSafeArea()
      
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
