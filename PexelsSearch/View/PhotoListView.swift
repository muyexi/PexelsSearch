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
            .searchable(text: $viewModel.searchText, prompt: "Search Photos")
        }
    }

    @ViewBuilder private var content: some View {
        switch viewModel.status {
        case .loading:
            Text(viewModel.statusMessage)
            ProgressView()
        case let .loaded(result):
            gridView(photos: result.photos)
            Text(viewModel.statusMessage).font(.footnote).foregroundColor(.gray)
        default:
            Text(viewModel.statusMessage)
        }
    }

    func gridView(photos: [Photo]) -> some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(photos) { photo in
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
    }
}

struct PhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = PhotoListViewModel(service: PhotoListService(webRepository: SearchPhotoWebRepository()))
        PhotoListView(viewModel: viewModel)
    }
}
