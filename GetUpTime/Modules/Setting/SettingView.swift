//
//  SettingView.swift
//  GetUpTime
//
//  Created by Rodrigo Souza on 08/09/2024.
//

import Epoxy
import UIKit
import UIKitNavigation

extension Setting {
    class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
        
        private let collectionView: UICollectionView = {
            let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
                switch sectionIndex {
                case 0:
                    // Seção da Imagem com Parallax
                    return ViewController.createParallaxHeaderSection()
                case 1:
                    // Seção com Título, Avaliações e Localização
                    return ViewController.createInfoSection()
                case 2:
                    // Seção de Atributos da Propriedade
                    return ViewController.createAttributesSection()
                default:
                    return nil
                }
            }
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .white
            
            collectionView.contentInsetAdjustmentBehavior = .never
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: "HeaderCollectionViewCell")
            collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: "InfoCollectionViewCell")
            collectionView.register(AttributeCollectionViewCell.self, forCellWithReuseIdentifier: "AttributeCollectionViewCell")
            return collectionView
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupViews()
            setupCollectionView()
            setupBottomButton()
        }

        private func setupBottomButton() {
            let buttonContainer = UIView()
            buttonContainer.translatesAutoresizingMaskIntoConstraints = false
            buttonContainer.backgroundColor = .white

            let priceLabel = UILabel()
            priceLabel.text = "$210 / night"
            priceLabel.font = .systemFont(ofSize: 16, weight: .bold)
            priceLabel.translatesAutoresizingMaskIntoConstraints = false

            let checkAvailabilityButton = UIButton(type: .system)
            checkAvailabilityButton.setTitle("Check availability", for: .normal)
            checkAvailabilityButton.setTitleColor(.white, for: .normal)
            checkAvailabilityButton.backgroundColor = .systemPink
            checkAvailabilityButton.layer.cornerRadius = 8
            checkAvailabilityButton.translatesAutoresizingMaskIntoConstraints = false

            buttonContainer.addSubview(priceLabel)
            buttonContainer.addSubview(checkAvailabilityButton)
            view.addSubview(buttonContainer)

            NSLayoutConstraint.activate([
                buttonContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                buttonContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                buttonContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                buttonContainer.heightAnchor.constraint(equalToConstant: 60),

                priceLabel.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
                priceLabel.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 16),

                checkAvailabilityButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor),
                checkAvailabilityButton.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -16),
                checkAvailabilityButton.heightAnchor.constraint(equalToConstant: 40),
                checkAvailabilityButton.widthAnchor.constraint(equalToConstant: 160)
            ])
        }

        private func setupViews() {
            view.addSubview(collectionView)

            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }

        private func setupCollectionView() {
            collectionView.dataSource = self
            collectionView.delegate = self
        }

        // MARK: - UICollectionViewDataSource
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 3 // Três seções: imagem, informações e atributos
        }

        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 1
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCollectionViewCell", for: indexPath) as! HeaderCollectionViewCell
                cell.configure(with: UIImage(named: "cabin")!)
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InfoCollectionViewCell", for: indexPath) as! InfoCollectionViewCell
                cell.configure(with: "Dreamy A-Frame Cabin in the Woods", rating: "5.0 (225) · Superhost", location: "Idyllwild-Pine Cove, California, United States")
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AttributeCollectionViewCell", for: indexPath) as! AttributeCollectionViewCell
                cell.configure(with: "Entire cabin hosted by Samantha", value: "5 guests · 2 bedrooms · 3 beds · 1 bath")
                return cell
            default:
                return UICollectionViewCell()
            }
        }

        // MARK: - Seções Composicionais
        static func createParallaxHeaderSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.4))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .none
            
            // Comportamento de Parallax + Sticky
            section.visibleItemsInvalidationHandler = { items, contentOffset, environment in
                let minY = contentOffset.y
                for item in items {
                    // Parallax Effect
                    let yOffset = minY > 0 ? 0 : minY / 2
                    item.transform = CGAffineTransform(translationX: 0, y: yOffset)
                    
                    // Sticky Effect
                    let maxY = minY > 0 ? minY : 0
                    item.transform = CGAffineTransform(translationX: 0, y: maxY)
                }
            }

            return section
        }

        static func createInfoSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(150))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(150))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            return NSCollectionLayoutSection(group: group)
        }

        static func createAttributesSection() -> NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

            return NSCollectionLayoutSection(group: group)
        }
    }

    class HeaderCollectionViewCell: UICollectionViewCell {
        private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
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

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }

        func configure(with image: UIImage) {
            imageView.image = image
        }
    }
    
    class InfoCollectionViewCell: UICollectionViewCell {
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 24, weight: .bold)
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let ratingLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .gray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let locationLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .gray
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
            contentView.addSubview(titleLabel)
            contentView.addSubview(ratingLabel)
            contentView.addSubview(locationLabel)

            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

                ratingLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                ratingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

                locationLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8),
                locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            ])
        }

        func configure(with title: String, rating: String, location: String) {
            titleLabel.text = title
            ratingLabel.text = rating
            locationLabel.text = location
        }
    }
    
    class AttributeCollectionViewCell: UICollectionViewCell {
        private let attributeLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .black
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let valueLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .gray
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
            contentView.addSubview(attributeLabel)
            contentView.addSubview(valueLabel)

            NSLayoutConstraint.activate([
                attributeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                attributeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                attributeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

                valueLabel.topAnchor.constraint(equalTo: attributeLabel.bottomAnchor, constant: 4),
                valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            ])
        }

        func configure(with attribute: String, value: String) {
            attributeLabel.text = attribute
            valueLabel.text = value
        }
    }
}


