

import SwiftUI
import GoogleSignIn
import Firebase

@main
struct YATOApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var viewModel = AuthenticationViewModel()

    init() {
        setupAuthentication()
        //setUpAuthentication_JustGoogle()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
//            LoginView()
//                .environmentObject(viewModel)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}

extension YATOApp {
    private func setUpAuthentication_JustGoogle() {
        GIDSignIn.sharedInstance().clientID = "467692619535-srotu5lfjlomhm3s27hdobfh48b96ubl.apps.googleusercontent.com"
    }
}

extension YATOApp {
    private func setupAuthentication() {
      FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID

    }

}


