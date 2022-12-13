//
//  NewsSingleView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct NewsSingleView: View {
    @EnvironmentObject var realmManager: RealmManager
    
    let article: Article
    @State var favourite = false
    
    
    var body: some View {
        VStack {
            // Article contents
            WebImage(url: article.imageURL)
                .resizable()
                .frame(height: 250)
            
            VStack(alignment: .leading) {
                Text(article.title)
                    .font(.headline)
                Text(article.descriptionText)
                    .font(.subheadline)
                    .lineLimit(3)
                
                // Publish info - source name and time
                HStack {
                    Text(article.publishInfo)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button {
                        if !realmManager.isArticleSaved(articleId: article.id) {
                            realmManager.addFavourite(from: article)
                        } else {
                            realmManager.removeFavourite(remove: article.id)
                        }
                    } label: {
                        Image(systemName: realmManager.isArticleSaved(articleId: article.id) ? "heart.fill" : "heart")
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.pink)
                    
                    Button {
                        shareButtonView(url: article.url)
                    } label: {
                        Image(systemName: "square.and.arrow.up")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding([.horizontal, .bottom], 10)
        }
        
    }
}

// add to extensions group and in a new file later
extension View {
    func shareButtonView(url: String) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
            .keyWindow?
            .rootViewController?
            .present(activityVC, animated: true)
    }
}


struct NewsSingleView_Previews: PreviewProvider {
    static var previews: some View {
        NewsSingleView(article: NewsData.previewNewsData[12])
            .environmentObject(RealmManager())
    }
}
