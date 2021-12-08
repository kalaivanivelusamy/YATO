

import SwiftUI

struct Sidebar: View {
    var body: some View {
      
        NavigationView {
            List{
                Label("Tasks", systemImage: "book.closed")
                Label("Calendar", systemImage: "calendar")
                Label("Search", systemImage: "magnifyingglass")
                Label("Sign Out", systemImage: "signout")
                
            }
            .listStyle(SidebarListStyle())
//            .navigationTitle("YATO")
        }
        
    }
}

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
        Sidebar()
    }
}
