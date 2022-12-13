//
//  SettingsView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var newsDataVM: NewsDataViewModel
    
    var body: some View {
        List {
            Section("News") {
                Picker("Country", selection: $newsDataVM.fetchPickerValues.country) {
                    ForEach(NewsCountry.allCases) {
                        Text($0.text)
                            .tag($0)
                    }
                }
                
                Picker("Category", selection: $newsDataVM.fetchPickerValues.category) {
                    ForEach(NewsCategory.allCases) {
                        Text($0.text)
                            .tag($0)
                    }
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(newsDataVM: NewsDataViewModel())
    }
}
