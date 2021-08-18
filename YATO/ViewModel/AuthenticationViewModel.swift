
import Foundation
import GoogleSignIn

class AuthenticationViewModel: NSObject,ObservableObject {
    
    @Published var state: SignInState = .signedOut

    enum SignInState {
        
        case signedIn
        case signedOut
    }
    
    override init() {
        super.init()
        setupGoogleSignIn() 
    }
    
    private func setupGoogleSignIn()
    {
        GIDSignIn.sharedInstance().delegate = self
    }
    
    func signIn(){
        
        if GIDSignIn.sharedInstance().currentUser == nil {
          GIDSignIn.sharedInstance().presentingViewController = UIApplication.shared.windows.first?.rootViewController
          GIDSignIn.sharedInstance().signIn()
        }
    }
    
    func signOut() {
      GIDSignIn.sharedInstance().signOut()
        state = .signedOut
    }

}


extension AuthenticationViewModel: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if error == nil {
            if let authentication = user.authentication {
                let credential = GoogleAuthProvider.credential(authentication)
            }
        }
        print(" Signed in \(error.debugDescription) and \(user.authentication)")
        self.state = .signedIn
    }
    
    
}
