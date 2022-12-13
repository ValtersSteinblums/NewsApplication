//
//  TommorowsTempView.swift
//  NewsApplication
//
//  Created by valters.steinblums on 13/12/2022.
//

import SwiftUI

struct TommorowsTempView: View {
    var body: some View {
        VStack {
            Text("Tommorow's Temperature")
                .fontWeight(.bold)
            Text("A little colder than today.")
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

struct TommorowsTempView_Previews: PreviewProvider {
    static var previews: some View {
        TommorowsTempView()
    }
}
