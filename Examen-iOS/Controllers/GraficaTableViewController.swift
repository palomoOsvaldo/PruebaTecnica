//
//  GraficaTableViewController.swift
//  Examen-iOS
//
//  Created by Osvaldo Salas on 29/06/21.
//

import UIKit

class GraficaTableViewController: UITableViewController {
    
    var questions = [Questions]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(GraficasTableViewCell.self, forCellReuseIdentifier: GraficasTableViewCell.identifier)
        WebServices.loadData { (response, success) in
          if success == true {
            self.questions = response!.questions
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
          }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GraficasTableViewCell.identifier, for: indexPath) as! GraficasTableViewCell
        if questions.count != 0 {
            let question = questions[0]
            cell.customizeChart(chartData: question.chartData)
        }

        return cell
    }

}
