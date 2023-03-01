import SwiftUI

struct PhotoItemView: View {
    let size: Double
    var photo: Photo

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AsyncImage(url: URL(string: photo.src.medium)) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
            Text(photo.photographer)
                .frame(maxWidth: .infinity)
                .font(.subheadline)
                .foregroundColor(.black)
                .background(.white)
                .opacity(0.8)
                .lineLimit(1)
        }
    }
}

struct PhotoItemView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoItemView(size: UIScreen.main.bounds.width, photo: SearchResult.mockedData!.photos.first!)
    }
}
