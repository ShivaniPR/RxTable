import UIKit

class NumberDisplay: UICollectionViewCell {
fileprivate let bg: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    @objc func onTapImage(playerNumber : Int){
        let iv = UIImageView()
        if playerNumber == 1 {
            iv.image = #imageLiteral(resourceName: "circle")
        }
        if playerNumber == 2 {
            iv.image = #imageLiteral(resourceName: "cross")
        }
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        contentView.addSubview(iv)
        NSLayoutConstraint.activate([
            iv.topAnchor.constraint(equalTo:contentView.topAnchor),
            iv.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iv.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            iv.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bg)
        bg.isUserInteractionEnabled = true
        
        NSLayoutConstraint.activate([
            bg.topAnchor.constraint(equalTo:contentView.topAnchor),
            bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("Init is not implemented")
    }
}
