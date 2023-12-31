//
//  BookmarksView.swift
//  SeriesApp
//
//  Created by Ricardo Ribeiro on 30/06/23.
//

import SwiftUI
import RealmSwift

struct BookmarksView: View {
    @ObservedResults(BookmarkedSeries.self)
    var bookmarkedSeriesList

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("Bookmarks")
                    .font(.largeTitle)
                    .padding(.leading, 16)
                ZStack {
                    if bookmarkedSeriesList.isEmpty {
                        Text("You have not bookmarked any series yet.")
                    }
                    List {
                        ForEach(bookmarkedSeriesList, id: \.id) { bookmarkedSeries in
                            SerieCellView(series: Helper.convertBookmarkedSeriesToSeries(bookmarkedSeries))
                        }
                        .onDelete { index in
                            $bookmarkedSeriesList.remove(atOffsets: index)
                        }
                        .listRowSeparator(.hidden)
                    }
                }
            }
        }
    }
}

struct BookmarksView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarksView()
    }
}
