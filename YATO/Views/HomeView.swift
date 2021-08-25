

import SwiftUI
import GoogleSignIn


struct MainView: View {
    @Binding var showMenu: Bool 
    var body: some View {
        Button(action: {
            print("Open the side Menu")
            withAnimation{
                showMenu.toggle()
            }
        }, label: {
            Text("Show Menu")
        })
    }
}


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
                if $0.translation.width < -100 {
                    withAnimation {
                        showMenu.toggle()
                        }
                    }
            }
        
        return NavigationView {
                    
                    GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                
                                VStack(alignment: .leading, spacing: 20) {
                                   
                                    CenterView()
                                
                            }
                                
                                
                                
//                                PersonalInfoView(showMenu: $showMenu)
//                                    .frame(width: geometry.size.width, height: geometry.size.height)
//                                    .offset(x: showMenu ? geometry.size.width/2 : 0)
//                                    .disabled(showMenu ? true : false )
                             
                                MenuView()
                                    .frame(width:geometry.size.width/2)
                                    .opacity(showMenu ? 1 : 0)
                                    .transition(.move(edge: .leading))
            }
            .gesture(drag)
        }
        .navigationBarTitle("YATO", displayMode: .inline)
        .navigationBarItems(leading: (Button(action: { withAnimation {
                                                self.showMenu.toggle()
                                        }}) {
                                            Image(systemName: "line.horizontal.3").imageScale(.large)
                                            }))
                    
        
            }
        
        
       /* NavigationView {
          VStack {
             // Sidebar()
            HStack {
              // 3
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
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(.secondarySystemFill))
            .cornerRadius(12)
            .padding()

            Spacer()

            // 4
            Button("Sign out") {
              viewModel.signOut()
            }
            .buttonStyle(AuthenticationButtonStyle())
          }
          .navigationTitle("YATO")
        }
        .navigationViewStyle(StackNavigationViewStyle())
 */
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
