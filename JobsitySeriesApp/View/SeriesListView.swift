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
                    LoadingView(width: 100, height: 120)
                case .loaded:
                    SeriesListContainerView(viewModel: viewModel)
                case .error:
                    SeriesErrorView(viewModel: viewModel)
                }
            }
            .task {
                await viewModel.fetchSeries()
            }
        }
    }
}

struct SeriesListContainerView: View {
    @StateObject var viewModel: SeriesListViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text("Series")
                .font(.largeTitle)
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(viewModel.seriesList, id: \.id) { series in
                        SerieCellView(series: series)
                            .task {
                                if viewModel.recheadEndOfPage(series: series) {
                                    await viewModel.fetchSeriesNextPage()
                                }
                            }
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct SerieCellView: View {
    var series: Series

    var body: some View {
        NavigationLink(destination: SeriesDetailsView(viewModel: SeriesDetailsViewModel(), series: series)) {
            HStack {
                PosterContainerView(imageUrl: series.image.imageUrl, width: 90, height: 125)
                Text(series.name)
                    .font(.system(size: 20))
                    .padding(.leading, 8)
                Spacer()
            }
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 16)
        .buttonStyle(.plain)
    }
}

struct PosterContainerView: View {
    let imageUrl: String
    var width: CGFloat = 0
    var height: CGFloat = 0

    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            if let image = image.image {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .font(.system(size: 20))
            } else if image.error != nil || imageUrl.isEmpty {
                Text("poster not found")
                    .frame(width: width, height: height)
                    .multilineTextAlignment(.center)
                    .border(.gray, width: 0.5)
            } else {
                LoadingView(width: width, height: height)
            }
        }
    }
}

struct SeriesErrorView: View {
    @StateObject var viewModel: SeriesListViewModel

    var body: some View {
        VStack(spacing: 16) {
            Text("Sorry, something went wrong.")
            Button {
                Task {
                    await viewModel.fetchSeries()
                }
            } label: {
                Text("try again")
            }
        }
    }
}

struct LoadingView: View {
    var width: CGFloat = 0
    var height: CGFloat = 0

    var body: some View {
        ProgressView().progressViewStyle(.circular)
            .frame(width: width, height: height)
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListView(viewModel: SeriesListViewModel())
    }
}
