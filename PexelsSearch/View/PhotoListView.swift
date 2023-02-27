import SwiftUI

struct PhotoListView: View {
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
        }
    }

    @ViewBuilder private var content: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(SearchResult.mockedData?.photos ?? []) { photo in
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
        PhotoListView()
    }
}
