//
//  SearchView.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Search")
                    .font(.largeTitle)
                    .padding(.leading, 16)
                TextField("Search for series...", text: $viewModel.query)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .onChange(of: viewModel.query, perform: { query in
                        viewModel.fetchSearchedSerie(query: query)
                    })
                Spacer()
                HStack {
                    Spacer()
                    ZStack(alignment: .center) {
                        switch viewModel.state {
                        case .idle:
                            Text("Please search above.")
                        case .loading:
                            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                        case .loaded:
                            SearchViewContainer(viewModel: viewModel)
                        case .error:
                            SearchErrorView(viewModel: viewModel)
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct SearchViewContainer: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack (alignment: .leading) {
                ForEach(viewModel.series, id: \.id) { series in
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
struct SearchErrorView: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack (spacing: 16) {
            Text("Series not found.")
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel())
    }
}
