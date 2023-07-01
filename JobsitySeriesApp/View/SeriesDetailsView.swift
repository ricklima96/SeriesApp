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
            SeriesDetailsHeaderView(series: series)
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    PosterContainerView(imageUrl: series.image.imageUrl, width: 190, height: 235)
                        .padding(.bottom, 16)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text("rating:").font(.title3).bold()
                        Text(series.rating)
                    }
                    HStack {
                        Text("schedule:").font(.title3).bold()
                        ForEach (series.schedule.days, id: \.self) { day in
                            Text(day.lowercased())
                        }
                        Text("|")
                        Text(series.schedule.time)
                    }
                    HStack {
                        Text("genres:").font(.title3).bold()
                        ForEach (series.genres, id: \.self) { genre in
                            if genre != series.genres.last {
                                Text(genre.lowercased() + " |")
                            } else {
                                Text(genre.lowercased())
                            }
                        }
                    }
                    HStack (alignment: .top) {
                        Text("summary:").font(.title3).bold()
                        Text(series.summary)
                    }
                    EpisodeListView(viewModel: viewModel)
                        .padding(.bottom, 8)
                }
                .padding(.horizontal, 16)
            }
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
            Text(series.name).font(.largeTitle)
            Spacer()
            Button(action: {
                    try? realm.write {
                        realm.add(bookmarkedSeries, update: .all)
                        alreadyBookmarked = true
                }
            }) {
                Image(alreadyBookmarked ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .frame(width: 30, height: 40)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 20)
        .onAppear() {
            alreadyBookmarked = realm.object(ofType: BookmarkedSeries.self, forPrimaryKey: series.id) != nil
        }
    }
}


struct EpisodeListView: View {
    @StateObject var viewModel: SeriesDetailsViewModel
    
    var body: some View {
        Text("Episodes").font(.title).padding(.top, 16)
        switch viewModel.state {
        case .idle, .loading:
            ProgressView().progressViewStyle(.circular).frame(width: 50, height: 50)
        case .loaded:
            ForEach(viewModel.episodesList, id: \.id) { episode in
                EpisodeCellView(episode: episode)
            }
        case .error:
            Text("no episodes found.")
        }
    }
}

struct EpisodeCellView: View {
    var episode: Episode
    
    var body: some View {
        NavigationLink(destination: EpisodeDetailsView(episode: episode)) {
            HStack {
                Text("S\(episode.season) E\(episode.number)").font(.headline)
                Text(episode.name)
            }
        }.buttonStyle(.plain)
    }
}

struct SeriesDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesDetailsView(viewModel: SeriesDetailsViewModel(), series: Series(id: "1", rating: "9.5", name: "The Dome", image: Poster(imageUrl: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg"), schedule: Helper.checkEmptySchedules(schedule: ScheduleResponse(time: "20:00", days: ["fridays"])), genres: Helper.checkEmptyGenres(genres: ["dark comedy"]), summary: "Lorem ipsum dolor sit amet"))
    }
}

