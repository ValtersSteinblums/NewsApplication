//
//  CustomTabBar.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case heart
    case magnifyingglass
    case cloud
    case gearshape
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tab
    
    private var fillImage: String {
        if selectedTab.rawValue == "magnifyingglass" {
            return selectedTab.rawValue
        } else {
           return selectedTab.rawValue + ".fill"
        }
    }
    
    private var tabColor: Color {
        switch selectedTab {
        case .house:
            return .blue
        case .heart:
            return .pink
        case .magnifyingglass:
            return .indigo
        case .cloud:
            return .green
        case .gearshape:
            return .orange
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    Spacer()
                    Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
                        .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
                        .foregroundColor(selectedTab == tab ? tabColor : .gray)
                        .font(.system(size: 22))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.1)) {
                                selectedTab = tab
                            }
                        }
                    Spacer()
                }
            }
            .frame(width: nil, height: 60)
            .background(.thinMaterial)
            //.background(.blue)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.house))
    }
}
