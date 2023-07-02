//
//  SearchView.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import SwiftUI

struct SearchSeriesView: View {
    @StateObject var viewModel: SearchSeriesViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchHeaderView(viewModel: viewModel)
                Spacer()
                HStack {
                    Spacer()
                    ZStack(alignment: .center) {
                        switch viewModel.state {
                        case .idle:
                            Text("Please search above.")
                        case .loading:
                            LoadingView(width: 50, height: 50)
                        case .loaded:
                            SearchResultsContainerView(viewModel: viewModel)
                        case .error:
                            Text("Series not found.")
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct SearchHeaderView: View {
    @StateObject var viewModel: SearchSeriesViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Search")
                .font(.largeTitle)
            SearchBarView(viewModel: viewModel)
        }
        .padding(.horizontal, 16)
    }
}

struct SearchBarView: View {
    @StateObject var viewModel: SearchSeriesViewModel

    var body: some View {
        TextField(" Search for series...", text: $viewModel.query)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .onChange(of: viewModel.query, perform: { _ in
                Task { await viewModel.fetchSearchedSerie(query: viewModel.query) }
            })
    }
}

struct SearchResultsContainerView: View {
    @StateObject var viewModel: SearchSeriesViewModel

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.seriesList, id: \.id) { series in
                    SerieCellView(series: series)
                }
            }
        }
    }
}

struct SearchSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchSeriesView(viewModel: SearchSeriesViewModel())
    }
}
