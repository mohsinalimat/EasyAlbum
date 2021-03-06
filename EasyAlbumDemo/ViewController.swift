//
//  ViewController.swift
//  EasyAlbumDemo
//
//  Created by Ray on 2019/3/3.
//  Copyright © 2019 Ray. All rights reserved.
//

import UIKit
import Photos
import EasyAlbum

class ViewController: UIViewController {

    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mAlbumBtn: UIButton!
    
    private let CELL = "EasyAlbumDemoCell"
    private var datas: [AlbumData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        mTableView.register(UINib(nibName: CELL, bundle: nil), forCellReuseIdentifier: CELL)
        mTableView.estimatedRowHeight = 70.0
        mTableView.rowHeight = UITableView.automaticDimension
        mTableView.dataSource = self
        mTableView.delegate = self
        
        mAlbumBtn.layer.cornerRadius = 7.5
        mAlbumBtn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
    }
    
    @objc private func click(_ btn: UIButton) {
        EasyAlbum.of(appName: "EasyAlbum")
                 .limit(3)
                 .showGIF(true)
                 .sizeFactor(.fit(width: 1125.0, height: 2436.0))
                 .start(self, delegate: self)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let photo = datas[index]
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL, for: indexPath) as! EasyAlbumDemoCell
        let desc = """
        FileName 👉🏻 \(photo.fileName ?? "")
        FileUTI  👉🏻 \(photo.fileUTI ?? "")
        FileSize 👉🏻 \(photo.fileSize / 1024)KB
        """
        cell.data = (photo.image, desc)
        return cell
    }
}

extension ViewController: EasyAlbumDelegate {
    func easyAlbumDidSelected(_ photos: [AlbumData]) {
        if datas.count > 0 { datas.removeAll() }
        datas.append(contentsOf: photos)
        mTableView.reloadData()
        photos.forEach({ print("AlbumData 👉🏻 \($0)") })
    }
    
    func easyAlbumDidCanceled() {
        
    }
}
