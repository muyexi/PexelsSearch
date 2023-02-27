import SwiftUI

struct ContentView: View {
    var body: some View {
        PhotoListView(viewModel: PhotoListViewModel(service: SearchPhotoRepository()))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
