//
//  JobsitySeriesApp.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import SwiftUI

@main
struct JobsitySeriesApp: App {
        
    var body: some Scene {
        WindowGroup {
            TabView {
                SeriesListView(viewModel: SeriesListViewModel())
                    .tabItem {
                        Label("", systemImage: "sparkles.tv")
                    }
                SearchSeriesView(viewModel: SearchSeriesViewModel())
                    .tabItem {
                        Label("", systemImage: "sparkle.magnifyingglass")
                    }
                BookmarksView()
                    .tabItem {
                        Label("", systemImage: "bookmark.fill")
                    }
            }
        }
    }
}
