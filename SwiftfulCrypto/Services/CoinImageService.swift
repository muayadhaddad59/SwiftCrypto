//
//  COinImageServices.swift
//  SwiftfulCrypto
//
//  Created by Muayad El-Haddad on 2024-03-31.
//

import SwiftUI
import Combine

class CoinImageService{
    @Published var image: UIImage? = nil
    var imageSubscripition: AnyCancellable?
    private let coin: CoinModel
    private let fileManager = LocalFileManager.instance
    private let folderName = "coin_images"
    private let imageName: String
    
    init(coin: CoinModel) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage(){
        if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName){
            image = savedImage
            print("Retrieved image from File Manager!")
        }else{
            DownloadCoinImage()
        }
    }
    
    private func DownloadCoinImage(){
        print("Downloading image now ")
        imageSubscripition = NetworkingManager.download(urlString: coin.image)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink(
                receiveCompletion: NetworkingManager.handlecompletion,
                receiveValue: { [weak self] returnedImage in
                    guard let self = self, let downloadedImage = returnedImage else { return }
                    self.image = downloadedImage
                    self.imageSubscripition?.cancel()
                    self.fileManager.saveImage(image: downloadedImage, imageName: self.imageName, folderName: self.folderName)
                })
    }
}
