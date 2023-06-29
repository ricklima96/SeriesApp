//
//  EpisodeDetailsView.swift
//  JobsitySeriesApp
//
//  Created by Ricardo Ribeiro on 29/06/23.
//

import SwiftUI

struct EpisodeDetailsView: View {
    let episode: Episode
    
    var body: some View {
        VStack(alignment: .center) {
            Text(episode.name).font(.largeTitle)
            HStack {
                Spacer()
                PosterContainerView(url: episode.image.medium, width: 300, height: 400)
                Spacer()
            }
            .padding(.bottom, 16)
            VStack(spacing: 16) {
                Text("S\(episode.season)E\(episode.number)")
                Text(episode.summary)
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView(episode: Episode(id: "1", name: "Ozymandias", number: "1", season: "2", summary: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", image: Picture(medium: "https://static.tvmaze.com/uploads/images/medium_portrait/81/202627.jpg")))
    }
}

