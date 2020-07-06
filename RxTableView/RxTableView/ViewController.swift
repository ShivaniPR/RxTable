import UIKit
import RxDataSources
import RxSwift
import RxCocoa

extension MySection : SectionModelType {
    typealias Item = Int

    init(original: MySection, items: [Item]) {
        self = original
        self.items = items
    }
}

class ViewController: UIViewController, UIScrollViewDelegate {
    let disposeBag = DisposeBag()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(UICollectionViewCell.self , forCellWithReuseIdentifier: "Cell")
        return cv
    }()
    let sections = [
        MySection(items: [
            1,
            2,
            3,
            4
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        disp()

    }
    func disp(){
        let dataSource = RxCollectionViewSectionedReloadDataSource<MySection>(
              configureCell: { dataSource, cv, indexPath, item in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
                cell.backgroundColor = .blue
                return cell
        })

        Observable.just(sections)
            .bind(to: collectionView.rx.items(dataSource: dataSource)) //binding the observable to the table view
            .disposed(by: disposeBag)

    }
}




























