import SwiftUI

struct PostsView: View {
    @StateObject var viewModel = PostsViewModel()
    
    var body: some View {
        List(viewModel.posts) { post in
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.title)
                
                Text(post.body)
                    .font(.body)
            }
        }
        .task {
            await viewModel.fetchPosts()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.errorMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    PostsView()
}
