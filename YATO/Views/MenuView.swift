import SwiftUI
import Charts
import GoogleSignIn

struct MenuView: View {
    
    private let user = GIDSignIn.sharedInstance().currentUser
    let data = [0.7,0.1,0.3,0.5,0.6]
    @State private var completionAmount: CGFloat = 0.0

    let timer = Timer.publish(every:0.45, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .center,spacing:10) {
                NetworkImage(url: user?.profile.imageURL(withDimension: 200))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
                    .clipShape(Circle())
                Text(user?.profile.name ?? "")
                  .font(.headline)
                .foregroundColor(.white)
            }.padding(.top,200)
           
            Spacer()

            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Profile")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.padding(.top,30)
            
            HStack {
                    Image(systemName: "Categories")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Categories")
                    .foregroundColor(.gray)
                    .font(.headline)
                    }.padding(.top, 30)
           
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.white)
                    .imageScale(.large)
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.headline)
                } .padding(.top, 30)
            
           
            Spacer()
            
            VStack(alignment: .leading, spacing: 5) {
               //Graph for consistency
                
               Chart(data: [0.7,0.1,0.8,0.5,0.6])
                    .chartStyle(
                        LineChartStyle(.quadCurve, lineColor: Color(#colorLiteral(red: 0.3767060637, green: 1, blue: 0.7470368743, alpha: 1)), lineWidth: 3.0,trimTo: $completionAmount))
                    .shadow(radius: 3)
                    .frame(width: 200, height: 100, alignment: .leading) 
                            .onReceive(timer) { _ in
                                withAnimation {
                                    if completionAmount == 1 { 
                                        completionAmount = 0
                                    } else {
                                        completionAmount += 0.2
                                    }
                                }
                            }

                Text("Good")
                    .foregroundColor(.white)
                    .font(.headline)
                                
                Text("Consistency")
                    .foregroundColor(.white)
                    .font(.title2)
            }.padding(.bottom,50)
            
        }
        .padding(.leading,30)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(#colorLiteral(red: 0.04327090085, green: 0.1375527084, blue: 0.3708509803, alpha: 1)))
        .edgesIgnoringSafeArea(.all)

    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
