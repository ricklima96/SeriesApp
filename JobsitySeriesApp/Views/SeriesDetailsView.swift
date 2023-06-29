//
//  SeriesDetailsView.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import SwiftUI

struct SeriesDetailsView: View {
    @StateObject var viewModel: SeriesDetailsViewModel
    let series: Series
    
    var body: some View {
        ScrollView {
                Text(series.name).font(.largeTitle)
                    .padding(.leading, 16)
                    .padding(.top, 20)
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    AsyncImage(url: URL(string: series.image.medium ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .font(.system(size: 20))
                    } placeholder: {
                        ProgressView().progressViewStyle(.circular)
                            .frame(width: 300, height: 300)
                    }
                    .padding(.bottom, 16)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("time:").font(.title3)
                        Text(series.schedule.time ?? "-")
                    }
                    HStack {
                        Text("days:").font(.title3)
                        ForEach (series.schedule.days ?? ["-"], id: \.self) { day in
                            Text (day)
                        }
                    }
                    HStack {
                        Text("genres:").font(.title3)
                        ForEach (series.genres ?? ["-"], id: \.self) { genre in
                            Text (genre)
                        }
                    }
                    HStack (alignment: .top) {
                        Text("summary:").font(.title3)
                        Text (series.summary)
                    }
                    EpisodeListView(viewModel: viewModel)
                }
                .padding(.horizontal, 16)
            }.onAppear() {
                viewModel.fetchEpisodes(id: series.id)
            }
        }
    }
}

struct EpisodeListView: View {
    @StateObject var viewModel: SeriesDetailsViewModel
    
    var body: some View {
        Text("Episodes").font(.title)
            .padding(.top, 16)
        switch viewModel.state {
        case .idle, .loading:
            ProgressView().progressViewStyle(.circular)
                .frame(width: 50, height: 50)
        case .loaded:
            ForEach(viewModel.episodesList, id: \.id) { episode in
                NavigationLink(destination: EpisodeDetailsView(/*viewModel: SeriesDetailsViewModel(), */episode: episode)) {
                    Text("S\(episode.season)E\(episode.number) \(episode.name)")
                }.buttonStyle(.plain)
            }
        case .error:
            Text("no episodes found.")
        }
    }
}

struct SeriesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesDetailsView(viewModel: SeriesDetailsViewModel(), series: Series(id: "1", name: "The Dome", image: Picture(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg"), schedule: Schedule(time: "19:00", days: ["Friday", "Saturday"]), genres: ["Drama", "Dark Comedy"], summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."))
    }
}
