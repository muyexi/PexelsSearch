import SwiftUI

struct PhotoDetailView: View {
    var photo: Photo
    
    var body: some View {
        AsyncImage(url: URL(string: photo.src.large)) { image in
            image.resizable().scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}

struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: SearchResult.mockedData!.photos.first!)
    }
}
