import SwiftUI
import Charts

struct MenuView: View {
    

    var body: some View {
        VStack(alignment: .leading) {
            
            VStack(alignment: .center,spacing:10) {
                Image(uiImage: UIImage(named: "Profile")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100, alignment: .center)
                    
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.red,lineWidth: 2))
                Text("Name")
                    .foregroundColor(.white)
                    .font(.title)
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
            
            VStack(alignment: .leading, spacing: 5) {
               //Graph for consistency
                
                Chart(data: [0.7,0.1,0.3,0.5,0.6])
                    .chartStyle(
                        LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 3.0))
                    .shadow(radius: 3)
                    .frame(width: 200, height: 100, alignment: .leading)

                Text("Good")
                    .foregroundColor(.gray)
                    .font(.headline)
                                
                Text("Consistency")
                    .foregroundColor(.white)
                    .font(.title2)
            }.padding(.bottom,50)
            
        }
        .padding(.leading,30)
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
