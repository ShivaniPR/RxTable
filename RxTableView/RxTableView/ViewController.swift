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
    var dataSource: RxTableViewSectionedReloadDataSource<MySection>?
    let sections = [
        MySection(header: "First section", items: [
            1,
            2
        ]),
        MySection(header: "Second section", items: [
            3,
            4
        ])
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        display()
    }
    func display(){
        let dataSource = RxTableViewSectionedReloadDataSource<MySection>(
            configureCell: { ds, tv, indexPath, item in
                let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
                    cell.textLabel?.text = "Item \(item)"

                return cell
        },
            titleForHeaderInSection: { ds, index in
                return ds.sectionModels[index].header
        })
        self.dataSource = dataSource
        Observable.just(sections)
        .bind(to: tableView.rx.items(dataSource: dataSource))
        .disposed(by: disposeBag)
    }
}

