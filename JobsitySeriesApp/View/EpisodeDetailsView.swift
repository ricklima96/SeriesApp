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
            Text(episode.name)
                .font(.largeTitle)
                .padding(.horizontal, 16)
            HStack {
                Spacer()
                PosterContainerView(imageUrl: episode.image.imageUrl, width: 300, height: 200)
                Spacer()
            }
            .padding(.bottom, 16)
            VStack(spacing: 16) {
                Text("S\(episode.season) E\(episode.number)").font(.headline)
                Text(episode.summary)
                Spacer()
            }
            .padding(.horizontal, 16)
        }
    }
}

struct EpisodeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        EpisodeDetailsView(episode: Episode(id: "1", name: "Ozymandias", number: "1",
                                       season: "2", summary: "Lorem ipsum dolor sit.",
                                       image: Poster(imageUrl: "")))
    }
}
