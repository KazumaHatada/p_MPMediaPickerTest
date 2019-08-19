//
//  ViewController.swift
//  MPMediaPickerTest
//
//  Created by Kazuma Hatada on 2019/07/30.
//  Copyright © 2019 Kazuma Hatada. All rights reserved.
//

import UIKit
import MediaPlayer

class ViewController: UIViewController, MPMediaPickerControllerDelegate {

    @IBAction func bChoose(_ sender: UIButton) {
        // MPMediaPickerControllerのインスタンスを作成
        let picker = MPMediaPickerController()
        // ピッカーのデリゲートを設定
        picker.delegate = self
        // 複数選択を不可にする。（trueにすると、複数選択できる）
        picker.allowsPickingMultipleItems = false
        // ピッカーを表示する
        present(picker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var ivArtWork: UIImageView!
    
    @IBOutlet weak var lArtist: UILabel!
    
    @IBOutlet weak var lMusic: UILabel!
    
    @IBOutlet weak var lAlbum: UILabel!
    
    var mpc = MPMusicPlayerController.systemMusicPlayer

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    /// メディアアイテムピッカーでアイテムを選択完了したときに呼び出される
    func mediaPicker(_ mediaPicker: MPMediaPickerController, didPickMediaItems mediaItemCollection: MPMediaItemCollection) {
        
        // 選択した曲から最初の曲の情報を表示
        if let mediaItem = mediaItemCollection.items.first {
            // 曲情報表示
            // (a ?? b は、a != nil ? a! : b を示す演算子です)
            // (aがnilの場合にはbとなります)
            lArtist.text = mediaItem.artist ?? "不明なアーティスト"
            lMusic.text = mediaItem.title ?? "不明な曲"
            lAlbum.text = mediaItem.albumTitle ?? "不明なアルバム"
            
            // アートワーク表示
            if let artwork = mediaItem.artwork {
                ivArtWork.image = artwork.image(at: ivArtWork.bounds.size)
            } else {
                // アートワークがないとき
                // (今回は灰色表示としました)
                ivArtWork.image = nil
                ivArtWork.backgroundColor = UIColor.gray
            }
        }
        
        // ピッカーを閉じ、破棄する
        dismiss(animated: true, completion: nil)
    }

    /// 選択がキャンセルされた場合に呼ばれる
    func mediaPickerDidCancel(_ mediaPicker: MPMediaPickerController) {
        // ピッカーを閉じ、破棄する
        dismiss(animated: true, completion: nil)
    }

}

