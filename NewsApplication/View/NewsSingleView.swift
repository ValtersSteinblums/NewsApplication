//
//  NewsSingleView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import SwiftUI

struct NewsSingleView: View {
    
    let article: Article
    
    var body: some View {
        VStack {
            // Article contents
//            WebImage(url: article.imageURL)
//                .resizable()
//                .frame(height: 250)
            
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
                        //
                    } label: {
                        //Image(systemName: favourite ? "heart.fill" : "heart")
                        Image(systemName: "heart")
                    }
                    .buttonStyle(.bordered)
                    .foregroundColor(.pink)
                    
                    Button {
                        //
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

struct NewsSingleView_Previews: PreviewProvider {
    static var previews: some View {
        NewsSingleView(article: NewsData.previewNewsData[12])
    }
}
