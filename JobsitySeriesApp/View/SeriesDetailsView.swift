//
//  SeriesDetailsView.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import SwiftUI
import RealmSwift

struct SeriesDetailsView: View {

    @StateObject var viewModel: SeriesDetailsViewModel
    var series: Series

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                SeriesDetailsHeaderView(series: series)
                SeriesDetailsEntriesView(series: series)
                EpisodeListView(viewModel: viewModel)
            }
            .padding(.horizontal, 16)
            .task {
                await viewModel.fetchEpisodes(id: series.id)
            }
        }
    }
}

struct SeriesDetailsHeaderView: View {
    @Environment(\.realm) var realm
    @State var alreadyBookmarked: Bool = false
    var series: Series

    var body: some View {
        HStack {
            let bookmarkedSeries = Helper.convertSeriesToBookmakedSeries(series)
            Text(series.name)
                .font(.largeTitle)
            Spacer()
            Button(action: {
                try? realm.write {
                    realm.add(bookmarkedSeries, update: .all)
                    alreadyBookmarked = true
                }
            }, label: {
                Image(alreadyBookmarked ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .frame(width: 26, height: 40)
            })
        }
        .onAppear {
            alreadyBookmarked = realm.object(ofType: BookmarkedSeries.self, forPrimaryKey: series.id) != nil
        }
    }
}

struct SeriesDetailsEntriesView: View {
    var series: Series

    var body: some View {
        HStack {
            Spacer()
            PosterContainerView(imageUrl: series.image.imageUrl, width: 190, height: 235)
            Spacer()
        }
        HStack {
            Text("rating:").font(.title3).bold()
            Text(series.rating)
        }
        HStack {
            Text("schedule:").font(.title3).bold()
            ForEach(series.schedule.days, id: \.self) { day in
                Text(day.lowercased())
            }
            Text("|")
            Text(series.schedule.time)
        }
        HStack {
            Text("genres:").font(.title3).bold()
            ForEach(series.genres, id: \.self) { genre in
                if genre != series.genres.last {
                    Text(genre.lowercased() + " |")
                } else {
                    Text(genre.lowercased())
                }
            }
        }
        HStack(alignment: .top) {
            Text("summary:").font(.title3).bold()
            Text(series.summary)
        }
    }
}

struct EpisodeListView: View {
    @StateObject var viewModel: SeriesDetailsViewModel

    var body: some View {
        Text("Episodes").font(.title2)
        switch viewModel.state {
        case .idle, .loading:
            LoadingView(width: 50, height: 50)
        case .loaded:
            EpisodeListContainerView(viewModel: viewModel)
        case .error:
            Text("no episodes found.")
        }
    }
}

struct EpisodeListContainerView: View {
    @StateObject var viewModel: SeriesDetailsViewModel

    var body: some View {
        ForEach(viewModel.episodesList, id: \.id) { episode in
            NavigationLink(destination: EpisodeDetailsView(episode: episode)) {
                HStack {
                    Text("S\(episode.season) E\(episode.number)")
                        .font(.headline)
                    Text(episode.name)
                }
            }
        }
    }
}

struct SeriesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesDetailsView(viewModel: SeriesDetailsViewModel(),
                          series: Series(id: "1", rating: "9.5",
                          name: "The Dome", image: Poster(imageUrl: ""),
                          schedule: Helper.formatSchedules(schedule: ScheduleResponse(time: "-", days: ["-"])),
                          genres: Helper.formatGenres(genres: ["-"]),
                          summary: "Lorem ipsum dolor sit amet"))
    }
}
