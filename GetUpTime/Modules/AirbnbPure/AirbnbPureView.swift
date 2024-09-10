//
//  AirbnbPureView.swift
//  GetUpTime
//
//  Created by Rodrigo Souza on 09/09/2024.
//

import Epoxy
import UIKit
import UIKitNavigation
//
//extension AirbnbPure {
//    class StretchyHeaderLayout: UICollectionViewFlowLayout {
//        override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//            let layoutAttributes = super.layoutAttributesForElements(in: rect)
//            
//            layoutAttributes?.forEach { attributes in
//                if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
//                    guard let collectionView = collectionView else { return }
//                    
//                    let contentOffsetY = collectionView.contentOffset.y
//                    
//                    if contentOffsetY < 0 {
//                        let width = collectionView.frame.width
//                        let height = attributes.frame.height - contentOffsetY
//                        
//                        attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
//                    }
//                }
//            }
//            
//            return layoutAttributes
//        }
//        
//        override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
//            return true
//        }
//    }
//
//    class ViewController: UIViewController {
//        private let collectionView: UICollectionView = {
//            let layout = StretchyHeaderLayout()
//            layout.scrollDirection = .vertical
//            layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
//            
//            let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//            cv.backgroundColor = .systemBackground
//            cv.translatesAutoresizingMaskIntoConstraints = false
//            return cv
//        }()
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            
//            view.addSubview(collectionView)
//            NSLayoutConstraint.activate([
//                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//            ])
//            
//            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
//            collectionView.register(StretchyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
//            
//            collectionView.dataSource = self
//            collectionView.delegate = self
//        }
//    }
//
//
//
//    class StretchyHeaderView: UICollectionReusableView {
//        private let imageView: UIImageView = {
//            let iv = UIImageView()
//            iv.contentMode = .scaleAspectFill
//            iv.clipsToBounds = true
//            iv.image = UIImage(named: "cabin")
//            iv.translatesAutoresizingMaskIntoConstraints = false
//            return iv
//        }()
//        
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//            
//            addSubview(imageView)
//            NSLayoutConstraint.activate([
//                imageView.topAnchor.constraint(equalTo: topAnchor),
//                imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
//                imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//                imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
//            ])
//        }
//        
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//    }
//}
//
//
//
//
//extension AirbnbPure.ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
//        cell.backgroundColor = .systemGray5
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        guard kind == UICollectionView.elementKindSectionHeader else {
//            return UICollectionReusableView()
//        }
//        
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! AirbnbPure.StretchyHeaderView
//        return headerView
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 200)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (view.frame.width - 48) / 2
//        return CGSize(width: width, height: width)
//    }
//}
import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        layoutAttributes?.forEach { attributes in
            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
                guard let collectionView = collectionView else { return }
                
                let contentOffsetY = collectionView.contentOffset.y
                
                if contentOffsetY < 0 {
                    let width = collectionView.frame.width
                    let height = attributes.frame.height - contentOffsetY
                    
                    attributes.frame = CGRect(x: 0, y: contentOffsetY, width: width, height: height)
                }
            }
            
            
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}

class StretchyHeaderView: UICollectionReusableView {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.image = UIImage(named: "cabin")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AirbnbStyleCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let detailsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            detailsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            detailsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            detailsLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: detailsLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func configure(with property: Property) {
        imageView.image = UIImage(named: property.imageName)
        titleLabel.text = property.title
        detailsLabel.text = "\(property.guests) guests · \(property.bedrooms) bedrooms"
        priceLabel.text = "$\(property.price) / night"
    }
}

struct Property {
    let imageName: String
    let title: String
    let guests: Int
    let bedrooms: Int
    let price: Int
}

class StretchyHeaderViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = StretchyHeaderLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemBackground
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    private let properties: [Property] = [
        Property(imageName: "cabin", title: "Dreamy A-Frame Cabin in the Woods", guests: 5, bedrooms: 2, price: 210),
        Property(imageName: "cabin", title: "Cozy Mountain Retreat", guests: 4, bedrooms: 1, price: 180),
        Property(imageName: "cabin", title: "Lakeside Cottage with Stunning Views", guests: 6, bedrooms: 3, price: 250),
        Property(imageName: "cabin", title: "Modern Treehouse Experience", guests: 2, bedrooms: 1, price: 150),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        collectionView.register(AirbnbStyleCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.register(StretchyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension StretchyHeaderViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return properties.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! AirbnbStyleCell
        cell.configure(with: properties[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! StretchyHeaderView
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width * 0.8)
    }
}
