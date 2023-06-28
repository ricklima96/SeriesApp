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
                SearchView(viewModel: SearchViewModel())
                    .tabItem {
                        Label("", systemImage: "sparkle.magnifyingglass")
                    }
            }
        }
    }
}
