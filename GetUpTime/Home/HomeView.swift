//
//  Home.swift
//  GetUpTime
//
//  Created by Rodrigo Souza on 07/09/24.
//

import Epoxy
import UIKit
import UIKitNavigation

final class HomeView: CollectionViewController {
    
    // MARK: - Enum Properties
    
    private enum SectionID {
        case carousel, list
    }
    
    init() {
        super.init(layout: UICollectionViewCompositionalLayout.epoxy)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        observe { [weak self] in
            guard let self else { return }
            
            setSections(sections, animated: false)
        }
    }
    @SectionModelBuilder
    private var sections: [SectionModel] {
        SectionModel(dataID: SectionID.carousel) {
            (0..<10).map { (dataID: Int) in
                TextRow.itemModel(
                    dataID: dataID,
                    content: .init(title: "Page \(dataID)"),
                    style: .large)
                .didSelect { _ in
                    // swiftlint:disable:next no_direct_standard_out_logs
                    print("Carousel page \(dataID) did select")
                }
                .willDisplay { _ in
                    // swiftlint:disable:next no_direct_standard_out_logs
                    print("Carousel page \(dataID) will display")
                }
            }
        }
        .supplementaryItems(ofKind: UICollectionView.elementKindSectionHeader, [
            TextRow.supplementaryItemModel(dataID: 0, content: .init(title: "Carousel section"), style: .large),
        ])
        .compositionalLayoutSection(.carouselWithHeader)
        
        SectionModel(dataID: SectionID.list) {
            (0..<10).map { (dataID: Int) in
                TextRow.itemModel(
                    dataID: dataID,
                    content: .init(title: "Row \(dataID)", body: "Textttt"),
                    style: .small)
                .didSelect { _ in
                    // swiftlint:disable:next no_direct_standard_out_logs
                    print("List row \(dataID) selected")
                }
                .willDisplay { _ in
                    // swiftlint:disable:next no_direct_standard_out_logs
                    print("List row \(dataID) will display")
                }
            }
        }
        .supplementaryItems(ofKind: UICollectionView.elementKindSectionHeader, [
            TextRow.supplementaryItemModel(dataID: 0, content: .init(title: "List section"), style: .large),
        ])
        .compositionalLayoutSectionProvider(NSCollectionLayoutSection.listWithHeader)
    }
}

// MARK: - TextRow

final class TextRow: UIView, EpoxyableView {
    
    // MARK: Lifecycle
    
    init(style: Style) {
        self.style = style
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layoutMargins = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        group.install(in: self)
        group.constrainToMarginsWithHighPriorityBottom()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    enum Style {
        case small, large
    }
    
    struct Content: Equatable {
        var title: String?
        var body: String?
    }
    
    func setContent(_ content: Content, animated _: Bool) {
        let titleStyle: UIFont.TextStyle
        let bodyStyle: UIFont.TextStyle
        
        switch style {
        case .large:
            titleStyle = .headline
            bodyStyle = .body
        case .small:
            titleStyle = .body
            bodyStyle = .caption1
        }
        
        group.setItems {
            if let title = content.title {
                Label.groupItem(
                    dataID: DataID.title,
                    content: title,
                    style: .style(with: titleStyle))
                .adjustsFontForContentSizeCategory(true)
                .textColor(UIColor.label)
            }
            if let body = content.body {
                Label.groupItem(
                    dataID: DataID.body,
                    content: body,
                    style: .style(with: bodyStyle))
                .adjustsFontForContentSizeCategory(true)
                .numberOfLines(0)
                .textColor(UIColor.secondaryLabel)
            }
        }
    }
    
    // MARK: Private
    
    private enum DataID {
        case title
        case body
    }
    
    private let style: Style
    private let group = VGroup(spacing: 8)
}

// MARK: SelectableView

extension TextRow: SelectableView {
    func didSelect() {
        // Handle this row being selected, e.g. to trigger haptics:
        UISelectionFeedbackGenerator().selectionChanged()
    }
}

// MARK: HighlightableView

extension TextRow: HighlightableView {
    func didHighlight(_ isHighlighted: Bool) {
        UIView.animate(withDuration: 0.15, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction]) {
            self.transform = isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
        }
    }
}

// MARK: DisplayRespondingView

extension TextRow: DisplayRespondingView {
    func didDisplay(_: Bool) {
        // Handle this row being displayed.
    }
}


// MARK: - Label

final class Label: UILabel, EpoxyableView {
    
    // MARK: Lifecycle
    
    init(style: Style) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        font = style.font
        numberOfLines = style.numberOfLines
        if style.showLabelBackground {
            backgroundColor = .secondarySystemBackground
        }
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Internal
    
    // MARK: StyledView
    
    struct Style: Hashable {
        let font: UIFont
        let showLabelBackground: Bool
        var numberOfLines = 0
    }
    
    // MARK: ContentConfigurableView
    
    typealias Content = String
    
    func setContent(_ content: String, animated _: Bool) {
        text = content
    }
    
}

extension Label.Style {
    static func style(
        with textStyle: UIFont.TextStyle,
        showBackground: Bool = false)
    -> Label.Style
    {
        .init(
            font: UIFont.preferredFont(forTextStyle: textStyle),
            showLabelBackground: showBackground)
    }
}



// MARK: - NSCollectionLayoutSection

extension NSCollectionLayoutSection {
    static var carouselWithHeader: NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(50)))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(widthDimension: .fractionalWidth(0.8), heightDimension: .estimated(50)),
            subitems: [item])
        group.contentInsets = .zero
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    static func listWithHeader(
        layoutEnvironment: NSCollectionLayoutEnvironment)
    -> NSCollectionLayoutSection
    {
        let section = list(layoutEnvironment: layoutEnvironment)
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
    
    static func list(layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        if #available(iOS 14, *) {
            return .list(using: .init(appearance: .plain), layoutEnvironment: layoutEnvironment)
        }
        
        let item = NSCollectionLayoutItem(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)))
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50)),
            subitems: [item])
        
        return NSCollectionLayoutSection(group: group)
    }
}



#if canImport(SwiftUI)
import SwiftUI

#Preview {
    UIViewControllerRepresenting {
        HomeView()
    }
}
#endif
