//
//  SeriesApp.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import SwiftUI

@main
struct SeriesApp: App {

    @StateObject var authViewModel: AuthenticationViewModel = AuthenticationViewModel()

    var body: some Scene {
        WindowGroup {
            Group {
                if authViewModel.isUnlocked || authViewModel.authMethod == "none" {
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
                } else {
                    AuthenticationView()
                }
            }.environmentObject(authViewModel)
        }
    }
}
