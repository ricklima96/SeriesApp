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
        ScrollView {
            LazyVStack (alignment: .leading) {
                ForEach(viewModel.series, id: \.id) { serie in
                    SerieCellView(serie: serie)
                    Divider()
                }
            }
        }.onAppear() {
            viewModel.fetchSeries()
        }
    }
}

struct SerieCellView: View {
    var serie: Serie
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: serie.image.medium ?? "")) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 150)
            } placeholder: {
                Text("Picture not found.")
            }
            
            Text(serie.name ?? "")
                .font(.system(size: 22))
                .padding(.leading, 8)
            Spacer()
        }
        .frame(width: .infinity, height: 150)
        .clipShape(RoundedRectangle(cornerRadius:20))
        .padding(.vertical, 6)
        .padding(.horizontal, 16)
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static var previews: some View {
        SeriesListView(viewModel: SeriesListViewModel())
    }
}
