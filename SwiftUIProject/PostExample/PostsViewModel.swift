import SwiftUI

class PostsViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var showAlert = false
    @Published var errorMessage = ""
    
    //MARK: - URLSession method
    //    func fetchPosts() {
    //        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return  }
    //
    //        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
    //            DispatchQueue.main.async {
    //                if let error {
    //                    self?.errorMessage = error.localizedDescription
    //                    self?.showAlert = true
    //                }
    //
    //                guard let data else {
    //                    self?.errorMessage = "Data is nil"
    //                    self?.showAlert = true
    //                    return
    //                }
    //
    //                do {
    //                    let posts = try JSONDecoder().decode([Post].self, from: data)
    //                    self?.posts = posts
    //                } catch {
    //                    self?.errorMessage = error.localizedDescription
    //                    self?.showAlert = true
    //                }
    //            }
    //        }
    //        .resume()
    //    }
    
    //MARK: - async await method
    func fetchPosts() async {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let posts = try JSONDecoder().decode([Post].self, from: data)
            DispatchQueue.main.async { self.posts = posts }
            
        } catch {
            self.errorMessage = error.localizedDescription
            self.showAlert = true
            
        }
    }
}
