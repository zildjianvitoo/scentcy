import SwiftUI
struct TestView: View {
    @Namespace var ns
    var body: some View {
        NavigationStack {
            NavigationLink(destination: Text("Detail").navigationTransition(.zoom(sourceID: "id", in: ns))) {
                Text("Tap")
            }
        }
    }
}
