//
//  SearchCollectionViewDataSource.swift
//  iTunesKeychainMVC
//
//  Created by Ибрагим Габибли on 07.01.2025.
//

import Foundation
import UIKit

final class SearchCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    var albums = [Album]()

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AlbumCollectionViewCell.id,
            for: indexPath)
                as? AlbumCollectionViewCell else {
            return UICollectionViewCell()
        }

        let album = albums[indexPath.item]
        let urlString = album.artworkUrl100

        ImageLoader.shared.loadImage(from: urlString) { loadedImage in
            DispatchQueue.main.async {
                guard let cell = collectionView.cellForItem(at: indexPath) as? AlbumCollectionViewCell  else {
                    return
                }
                cell.configure(with: album, image: loadedImage)
            }
        }
        return cell
    }
}
