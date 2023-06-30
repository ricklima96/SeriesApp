//
//  SeriesListView.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 27/06/23.
//

import SwiftUI

struct SeriesListView: View {
    @StateObject var viewModel: SeriesListViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView().progressViewStyle(.circular)
                        .frame(width: 100, height: 120)
                case .loaded:
                    SeriesViewContainer(viewModel: viewModel)
                case .error:
                    SeriesErrorView(viewModel: viewModel)
                }
            }.onAppear() {
                viewModel.fetchSeries()
            }
        }
    }
}

struct SeriesViewContainer: View {
    @StateObject var viewModel: SeriesListViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Series")
                .font(.largeTitle)
                .padding(.leading, 16)
            ScrollView {
                LazyVStack (alignment: .leading) {
                    ForEach(viewModel.seriesList, id: \.id) { series in
                        NavigationLink(destination: SeriesDetailsView(viewModel: SeriesDetailsViewModel(), series: series)) {
                            SerieCellView(series: series)
                                .onAppear() {
                                    if viewModel.recheadEndOfPage(series: series) {
                                        viewModel.fetchSeriesNextPage()
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}

struct SerieCellView: View {
    var series: Series
    
    var body: some View {
        HStack {
            PosterContainerView(imageUrl: series.image.imageUrl, width: 90, height: 125)
            Text(series.name)
                .font(.system(size: 20))
                .padding(.leading, 8)
            Spacer()
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 16)
    }
}

struct SeriesErrorView: View {
    @StateObject var viewModel: SeriesListViewModel
    
    var body: some View {
        VStack (spacing: 16) {
            Text("Sorry, something went wrong.")
            Button {
                viewModel.fetchSeries()
            } label: {
                Text("try again")
            }
        }
    }
}

struct PosterContainerView: View {
    let imageUrl: String?
    var width: CGFloat? = 0
    var height: CGFloat? = 0
    
    var body: some View {
        AsyncImage(url: URL(string: imageUrl ?? "")) { image in
            if let image = image.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .font(.system(size: 20))
            } else if image.error != nil || imageUrl == nil {
                Text("poster not found")
                    .frame(width: width, height: height)
                    .multilineTextAlignment(.center)
                    .border(.gray, width: 0.5)
            } else {
                ProgressView().progressViewStyle(.circular)
                    .frame(width: width, height: height)
            }
        }
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListView(viewModel: SeriesListViewModel())
    }
}
