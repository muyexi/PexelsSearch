import SwiftUI

struct PhotoListView: View {
    @ObservedObject private(set) var viewModel: PhotoListViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack {
            NavigationStack {
                self.content
                    .navigationTitle("Pexels")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .searchable(text: $viewModel.searchText)
        }
    }

    @ViewBuilder private var content: some View {
        switch viewModel.status {
        case .loading:
            Text(viewModel.statusMessage)
            ProgressView()
        case let .loaded(result):
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(result.photos) { photo in
                        NavigationLink(destination: PhotoDetailView(photo: photo)) {
                            GeometryReader { geo in
                                PhotoItemView(size: geo.size.width, photo: photo)
                            }
                        }
                        .cornerRadius(8.0)
                        .aspectRatio(1, contentMode: .fit)
                    }
                }
                .padding()
            }
            Text(viewModel.statusMessage).font(.footnote).foregroundColor(.gray)
        default:
            Text(viewModel.statusMessage)
        }
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoListView(viewModel: PhotoListViewModel(service: SearchPhotoRepository()))
    }
}
