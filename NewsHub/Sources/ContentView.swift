import SwiftUI

public struct ContentView: View {
    public init() {}

    public var body: some View {
        VStack {
            Text("Hello, World!")
                .padding()
            let apiKey = Bundle.main.infoDictionary?["NEWS_API_KEY"] as? String
            Text("\(apiKey ?? "")")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
