//
//  ARContentTableViewController.swift
//  AR Quick Look
//
//  Created by Anand Nigam on 07/06/19.
//  Copyright © 2019 Anand Nigam. All rights reserved.
//

import UIKit
import QuickLook

class ARContentTableViewController: UITableViewController, QLPreviewControllerDelegate, QLPreviewControllerDataSource {

    // Array containing the name of all the 3d models and their images
    private let modelsName = ["wheelbarrow", "wateringcan", "teapot", "gramophone", "cupandsaucer", "redchair", "tulip", "plantpot", "fender", "plane", "car", "retro tv", "robot", "drummer"]
    // To keep the track of selected cell in tableView
    private var selectedModelIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // To register the tableView custom cell
        tableView.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "modelDetailCell")
    }

    // MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelsName.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Making the cell with appropriate information
        let cell = tableView.dequeueReusableCell(withIdentifier: "modelDetailCell", for: indexPath) as! DetailTableViewCell
        let modelName = modelsName[indexPath.row]
        cell.modelTitleLabel.text = modelName.capitalized
        if let image = UIImage(named: "\(modelName)") {
            cell.modelImageView.image = image
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselecting the selected cell
        tableView.deselectRow(at: indexPath, animated: true)
        // Storing the index path of the selected cell
        selectedModelIndex = indexPath.row
        
        // Making the instance of Quick Look Controller, Setting its data source and delegate, and presenting it
        let previewController = QLPreviewController()
        previewController.dataSource = self
        previewController.delegate = self
        present(previewController, animated: true)
    }
    
    // MARK:- ARQuickLook DataSource Methods
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        // Getting the URL or path of the selected 3d model which will be of type .usdz
        let url = Bundle.main.url(forResource: modelsName[selectedModelIndex], withExtension: "usdz")!
        // Returning the url as Preview Item to be displayed by the Quick Look
        return url as QLPreviewItem
    }

}
