import SwiftUI
import SwiftUICharts

struct MenuView: View {
    

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Profile")
                    .foregroundColor(.gray)
                    .font(.headline)
            }.padding(.top,100)
            
            HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Messages")
                    .foregroundColor(.gray)
                    .font(.headline)
                    }.padding(.top, 30)
           
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Settings")
                    .foregroundColor(.gray)
                    .font(.headline)
                } .padding(.top, 30)
            
           
            Spacer()
            
            VStack {
               //Graph for consistency
                LineView(data: [8,23,54,32,12,37,7,23,43])
                    
                    .padding(20)

                Text("Good")
                    .foregroundColor(.gray)
                    .font(.headline)
                
                Text("Consistency")
                    .foregroundColor(.white)
                    .font(.title2)
            }.padding(.bottom,30)
            
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.all)

        }
    }

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
