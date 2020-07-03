import UIKit
import RxDataSources
import RxSwift
import RxCocoa


extension MySection : AnimatableSectionModelType {
    typealias Item = Int
    
    var identity: String {
        return header
    }
    
    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    let tableView = UITableView()
    var dataSource: RxTableViewSectionedAnimatedDataSource<MySection>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0)
        ])
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<MySection>(
            configureCell: { ds, tv, _, item in
                let cell = tv.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
                cell.textLabel?.text = "Item \(item)"
                
                return cell
        },
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
        }
        )
        
        self.dataSource = dataSource
        
        let sections = [
            MySection(header: "First section", items: [
                1,
                2,
            ]),
            MySection(header: "Second section", items: [
                3,
                4
            ])
        ]
        
        Observable.just(sections)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
    }
    
    
}


