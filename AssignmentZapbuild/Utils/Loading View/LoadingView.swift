//
//  LoadingView.swift
//  Appetizers
//
//  Created by Harpreet Singh on 20/10/23.
//

import SwiftUI

struct LoadingView:View {
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea(edges: .all)
            ProgressView().progressViewStyle(.circular)
        }
    }
}
