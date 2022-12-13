//
//  NewsFavouritesView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 12/12/2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsFavouritesListView: View {
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        VStack {
            List {
                ForEach(realmManager.favourites, id: \.id) { favourite in
                    if !favourite.isInvalidated {
                        VStack(alignment: .leading) {
                            WebImage(url: URL(string: favourite.newsImage))
                                .resizable()
                                .frame(height: 250)
                            
                            VStack(alignment: .leading) {
                                Text(favourite.newsTitle)
                                    .font(.headline)
                                HStack {
                                    Text(favourite.newsPublishInfo)
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                    
                                    Button {
                                        realmManager.removeFavourite(remove: favourite.id)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .buttonStyle(.bordered)
                                    .foregroundColor(.pink)
                                    
                                    Button {
                                        shareButtonView(url: favourite.newsUrl)
                                    } label: {
                                        Image(systemName: "square.and.arrow.up")
                                    }
                                    .buttonStyle(.bordered)
//                                    .foregroundColor(.pink)
                                }
                            }
                            .padding([.horizontal, .bottom], 10)
                        }
                        
                    }
                }
                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}

struct NewsFavouritesListView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFavouritesListView()
            .environmentObject(RealmManager())
    }
}
