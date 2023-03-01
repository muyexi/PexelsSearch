import SwiftUI

struct ContentView: View {
    var body: some View {
        let viewModel = PhotoListViewModel(service: PhotoListService(webRepository: PhotoListWebRepository()))
        PhotoListView(viewModel: viewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
