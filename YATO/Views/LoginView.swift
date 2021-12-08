

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        
        HStack(spacing:10){
            Button("Google"){
                viewModel.signIn()
            }.buttonStyle(AuthenticationButtonStyle())
            
            Button("Github") {
                
            }.buttonStyle(AuthenticationButtonStyle())
        }
       
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct AuthenticationButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .foregroundColor(.white)
      .padding()
      .frame(maxWidth: .infinity)
      .background(Color(.systemBlue))
      .cornerRadius(12)
       // .clipShape(Circle())
        .padding()



  }
}
