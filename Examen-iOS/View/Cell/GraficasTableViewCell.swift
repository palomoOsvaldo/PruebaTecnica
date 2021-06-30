//
//  GraficasTableViewCell.swift
//  Examen-iOS
//
//  Created by Osvaldo Salas on 29/06/21.
//

import UIKit
import Charts

class GraficasTableViewCell: UITableViewCell {
    
    static let identifier = "GraficaCell"
    var pieChartView: PieChartView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        isEditing = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customizeChart(chartData: [ChartData]) {
        print(chartData)
        pieChartView = PieChartView(frame: CGRect(x:0,y:0,width:400,height:400))
        pieChartView.backgroundColor = .clear
        addSubview(pieChartView)
        
        var dataEntries: [ChartDataEntry] = []
        for i in chartData  {
            let dataEntry1 = ChartDataEntry(x: Double(i.percetnage), y: Double(i.percetnage), data: i.percetnage as AnyObject)
              dataEntries.append(dataEntry1)
            }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Units Sold")
            let pieChartData = PieChartData(dataSet: pieChartDataSet)
            pieChartView.data = pieChartData
            
            var colors: [UIColor] = []
            
            for _ in chartData {
              let red = Double(arc4random_uniform(256))
              let green = Double(arc4random_uniform(256))
              let blue = Double(arc4random_uniform(256))
                
              let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
              colors.append(color)
            }
            pieChartDataSet.colors = colors
    }

}
