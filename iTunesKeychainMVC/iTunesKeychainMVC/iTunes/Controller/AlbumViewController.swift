//
//  AlbumViewController.swift
//  iTunesKeychainMVC
//
//  Created by Ибрагим Габибли on 30.12.2024.
//

import Foundation
import UIKit
import SnapKit

final class AlbumViewController: UIViewController {
    var album: Album?

    lazy var albumView = AlbumView(frame: .zero)

    override func loadView() {
        super.loadView()
        view = albumView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlbum()
    }

    private func setupAlbum() {
        guard let album else {
            return
        }

        let urlString = album.artworkUrl100
        ImageLoader.shared.loadImage(from: urlString) { [weak self] loadedImage in
            DispatchQueue.main.async {
                self?.albumView.albumImageView.image = loadedImage
            }
        }

        albumView.albumNameLabel.text = album.collectionName
        albumView.artistNameLabel.text = album.artistName
        albumView.collectionPriceLabel.text = "\(album.collectionPrice) $"
    }
}
