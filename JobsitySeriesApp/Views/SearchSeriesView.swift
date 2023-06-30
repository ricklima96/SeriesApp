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
                Text("Search")
                    .font(.largeTitle)
                    .padding(.leading, 16)
                SearchBarView(viewModel: viewModel)
                Spacer()
                HStack {
                    Spacer()
                    ZStack(alignment: .center) {
                        switch viewModel.state {
                        case .idle:
                            Text("Please search above")
                        case .loading:
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                        case .loaded:
                            SearchViewContainer(viewModel: viewModel)
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

struct SearchBarView: View {
    @StateObject var viewModel: SearchSeriesViewModel
    
    var body: some View {
        TextField("Search for series...", text: $viewModel.query)
            .padding(7)
            .padding(.horizontal, 25)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal, 10)
            .onChange(of: viewModel.query, perform: { query in
                Task {
                    await viewModel.fetchSearchedSerie(query: viewModel.query)
                }
            })
    }
}

struct SearchViewContainer: View {
    @StateObject var viewModel: SearchSeriesViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading) {
                ForEach(viewModel.seriesList, id: \.id) { series in
                    NavigationLink(destination: SeriesDetailsView(viewModel: SeriesDetailsViewModel(), series: series)) {
                        VStack {
                            SerieCellView(series: series)
                            Divider()
                        }
                    }
                    .buttonStyle(.plain)
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
