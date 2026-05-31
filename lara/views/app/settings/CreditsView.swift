import SwiftUI

struct CreditsView: View {
    var body: some View {
        NavigationStack {
            List {
                LinkCreditCell(
                    name: "Tristannvm",
                    description: "Developer",
                    url: "https://github.com/Tristannvm"
                ) {
                    LinkCreditIcon(url: "https://github.com/Tristannvm.png")
                }
            }
            .navigationTitle("Credits")
        }
    }
}
