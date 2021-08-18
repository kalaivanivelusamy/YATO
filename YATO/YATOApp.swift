

import SwiftUI
import GoogleSignIn
@main
struct YATOApp: App {
    let persistenceController = PersistenceController.shared
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var viewModel = AuthenticationViewModel()

    init() {
        setUpAuthentication()
    }

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            LoginView()
                .environmentObject(viewModel)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}

extension YATOApp {
    private func setUpAuthentication() {
        GIDSignIn.sharedInstance().clientID = "467692619535-srotu5lfjlomhm3s27hdobfh48b96ubl.apps.googleusercontent.com"
    }
}


