//
//  FieldOption.swift
//  common
//
//  Created by Michael Ong on 9/4/22.
//

import Foundation
import UIKit

public class ComponentFieldOption: UIView {
  public private(set) weak var labelView: UILabel!
  weak var tableContentView: UICollectionView!

  public var optionItems: [OptionItem] = [] {
    didSet {
      var newData = NSDiffableDataSourceSnapshot<Int, String>()
      newData.appendSections([0])
      newData.appendItems(optionItems.map(\.id), toSection: 0)

      listDataSource.apply(newData, animatingDifferences: false)
    }
  }

  lazy var listLayout = {
    var configuration = UICollectionViewCompositionalLayoutConfiguration()
    configuration.scrollDirection = .horizontal

    return UICollectionViewCompositionalLayout(sectionProvider: { _, _ in
      let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                          heightDimension: .fractionalHeight(1)))

      let group = NSCollectionLayoutGroup.horizontal(
        layoutSize: .init(widthDimension: .estimated(130),
                          heightDimension: .fractionalHeight(1)),
        subitems: [item]
      )

      let section = NSCollectionLayoutSection(group: group)
      section.interGroupSpacing = 8

      return section
    }, configuration: configuration)
  }()

  lazy var listDataSource: UICollectionViewDiffableDataSource<Int, String> = {
    let Cell = CellItem.Configuration()

    return .init(collectionView: tableContentView) { [unowned self] collectionView, indexPath, _ in
      collectionView.dequeueConfiguredReusableCell(using: Cell, for: indexPath, item: optionItems[indexPath.row])
    }
  }()

  override public init(frame: CGRect) {
    super.init(frame: frame)

    addSubviewAndPrepare(ComponentGroup.vertical) { group in
      group.withSpacing(8).withMargins(.init(top: 8, left: 12, bottom: 12, right: 12)).withArrangedSubviews {
        prepareView(ref: &labelView, view: UILabel()) { label in
          label.font = .fontWithVariant(for: .label)
          label.alpha = 0.6
        }
        prepareView(ref: &tableContentView,
                    view: UICollectionView(frame: .zero, collectionViewLayout: listLayout)) { table in
          table.clipsToBounds = false
          table.backgroundColor = .systemBackground
          table.showsHorizontalScrollIndicator = false

          NSLayoutConstraint.activate([table.heightAnchor == 130])
        }
      }

      tableContentView.dataSource = listDataSource

      NSLayoutConstraint.activate(group.layout(around: self))
    }
  }

  @available(*, unavailable)
  public required init?(coder _: NSCoder) {
    fatalError()
  }
}

public extension ComponentFieldOption {
  override class var layerClass: AnyClass { ComponentField.Background.self }
}

public extension ComponentFieldOption {
  struct OptionItem: Hashable, Identifiable {
    public let id: String

    public let icon: UIImage?
    public let title: String
    public let description: String?
  }
}

extension ComponentFieldOption {
  class CellItem: UICollectionViewCell {
    static func Configuration() -> UICollectionView.CellRegistration<CellItem, OptionItem> {
      .init { cell, _, item in
        cell.itemTitleView.text = item.title

        if let image = item.icon {
          cell.itemImageView.image = image
          cell.itemImageView.isHidden = false
        } else {
          cell.itemImageView.isHidden = true
        }

        if let description = item.description {
          cell.itemDetailView.text = description
          cell.itemDetailView.isHidden = false
        } else {
          cell.itemDetailView.isHidden = true
        }
      }
    }

    weak var itemImageView: UIImageView!
    weak var itemTitleView: UILabel!
    weak var itemDetailView: UILabel!

    override init(frame: CGRect) {
      super.init(frame: frame)

      backgroundView = CellItemBackground()
      contentView.addSubviewAndPrepare(ComponentGroup.vertical) { group in
        group.alignment = .center

        group.withSpacing(4).withMargins(.init(vertical: 8, horizontal: 8)).withArrangedSubviews {
          Spacer()
          prepareView(ref: &itemImageView, view: UIImageView()) { imageView in
            imageView.contentMode = .scaleAspectFit
          }
          prepareView(ref: &itemTitleView, view: UILabel()) { label in
            label.font = .fontWithVariant(for: .action2)
            label.textAlignment = .center
            label.numberOfLines = 2
          }
          Spacer()
          prepareView(ref: &itemDetailView, view: UILabel()) { label in
            label.font = .fontWithVariant(for: .label)
            label.alpha = 0.6
            label.textAlignment = .center
            label.numberOfLines = 0

            label.setContentHuggingPriority(.init(rawValue: 0), for: .vertical)
          }
        }

        NSLayoutConstraint.activate(group.layout(around: contentView, excluding: .bottom))
      }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
      fatalError()
    }
  }

  class CellItemBackground: UIView {
    override init(frame: CGRect) {
      super.init(frame: frame)

      layer.cornerRadius = 6
      layer.backgroundColor = UIColor.black.withAlphaComponent(0.05).cgColor
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
      fatalError()
    }
  }
}
