

import SwiftUI
import GoogleSignIn

struct LoginView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel

    var body: some View {
        
        Button("G"){
            viewModel.signIn()
        }.buttonStyle(AuthenticationButtonStyle())
        
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
//      .frame(maxWidth: .infinity)
      .background(Color(.systemIndigo))
      .cornerRadius(12)
        .clipShape(Circle())
      .padding()
  }
}
