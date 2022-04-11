

import UIKit


class ViewController: UIViewController {
    
    var characterList :  [Character] = []
    
    var tableView = UITableView ()
    
    
    struct Cells{
        static let mycell = "my cell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .white
        configureTableView()
        
        miApi.shared.fetchData { characters, error in
            
            DispatchQueue.main.async {
                guard let characters = characters else {
                    print(error?.message ?? "error")
                    return
                }
                self.characterList = characters
                self.tableView.reloadData()
            }
        }
        
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        setTableViewDelegates()
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(MyCell.self, forCellReuseIdentifier: Cells.mycell)
        tableView.pin(to :view)
        
    }
    func setTableViewDelegates(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    
    var selectedIndex = IndexPath(row: 0, section: 0)
    var shouldCellBeExpanded:Bool = false
}



//
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    //        indica cuantas celdas queremos que tenga nuestra tabla
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
//        if  shouldCellBeExpanded && selectedIndex == indexPath {return 200}
        if selectedIndex != indexPath {
            return 100
            
        }
        guard let cell :MyCell = self.tableView.cellForRow(at: selectedIndex) as? MyCell else {
            return 100
        }
        return cell.expanded ? 200 : 100
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return characterList.count
        
        //        print(characterList)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:Cells.mycell, for: indexPath as IndexPath) as! MyCell
//        let expandencell = self.characterList[indexPath.row]
        cell.results =  characterList[indexPath.row]
       
        
        //        cell.set(results: results)
        cell.selectionStyle = .none
        cell.miViewController = self
        cell.prepare()
//                cell.animated()
        //        print(indexPath.f)
        cell.myButton.tag = indexPath.row
        //        cell.myButton.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        cell.myButton.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return cell
        
        
    }
    
    @objc func clickButton(_ sender:UIButton) {
       let index = sender.tag
//
//        print(index)
        //        var rowNumber = indexPath
        //        let indexPath = IndexPath(item: rowNumber, section: 0)
              let cell :MyCell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as! MyCell
        cell.expanded.toggle()
//        let mycell: MyCell = self.tableView.hei
        
//        let rowNumber = index
        let indexPath = IndexPath(item: index, section: 0)
        //shouldCellBeExpanded.toggle()
//        print(index)
        
        selectedIndex = indexPath
//        shouldCellBeExpanded = !shouldCellBeExpanded
//        shouldCellBeExpanded.toggle()
        
//        print(shouldCellBeExpanded)
        //            indexOfExpendedCell = index
        //        print(IndexPath.init(row: , section: <#T##Int#>))
//        if cell.shouldCellBeExpanded == true {
        self.tableView.beginUpdates()
//        self.tableView.reloadSections([sender.tag], with: .fade)
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
//        self.tableView.performBatchUpdates(<#T##updates: (() -> Void)?##(() -> Void)?##() -> Void#>)
        self.tableView.endUpdates()
//            self.tableView.scrollToRow(at:  selectedIndex, at: .top, animated: true)
//            self.tableView.rowHeight = 200
            
        //                cell.myButton.configuration = .gray()
        //                cell.myButton.configuration?.title = "Status"
        //                cell.myButton.setTitle("X", for: .normal)
//                    }
//                    else {
//                        self.tableView.beginUpdates()
//                        self.tableView.reloadRows(at: [indexPath], with: .none)
//                        self.tableView.endUpdates()
//                        self.tableView.rowHeight = 100
//        ////                cell.btn_View.setTitle("+", for: .normal)
//                    }
    }
}




//extension ViewController: UITableViewDelegate{
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath)
//        selectedIndex = indexPath
//        tableView.beginUpdates()
//        tableView.reloadRows(at: [selectedIndex], with: .none)
//        tableView.endUpdates()

        //        let vcDetail = DetailTableView()
        //        vcDetail.dataContent = characterList[indexPath.row]
        //
        //
        //        navigationController?.pushViewController(vcDetail, animated: true)
//    }

//}
