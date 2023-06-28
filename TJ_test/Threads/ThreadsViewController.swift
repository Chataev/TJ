//
//  ThreadsViewController.swift
//  TJ_test
//
//  Created by Gleb Chataev on 26.06.23.
//

import UIKit
import SnapKit

// MARK: - ThreadsViewController
final class ThreadsViewController: UIViewController {
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.allowsSelection = false
        table.dataSource = self
        return table
    }()
    
    private let refreshControll = UIRefreshControl()
    
    // MARK: - Properties
    
    private var viewModel: ThreadsViewModel?

    // MARK: - Initialization
    
    init(viewModel: ThreadsViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        bindWithViewModel()
        viewModel?.getNewPage()
    }
    
    // MARK: - Private methods
    
    private func bindWithViewModel() {
        viewModel?.updateUI = { [weak self] in
            self?.tableView.reloadData()
            self?.refreshControll.endRefreshing()
        }
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        tableView.refreshControl = refreshControll
        tableView.rowHeight = UITableView.automaticDimension
        refreshControll.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc
    private func pullToRefresh() {
        viewModel?.getNewPage()
    }
}

// MARK: - UITableViewDataSource
extension ThreadsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel?.pageModels.count ?? .zero
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.pageModels[section].count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostCell()
        guard let model = viewModel?.pageModels[indexPath.section][indexPath.row] else { return UITableViewCell() }
        cell.indexPath = indexPath
        cell.delegate = self
        cell.configure(with: model)
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard
            viewModel?.isLoading == false,
            let pages = viewModel?.pageModels,
            let page = viewModel?.pageModels[indexPath.section]
        else { return }
        if indexPath.row == page.count - 1, indexPath.section < pages.count {
            viewModel?.getNewPage()
        }
    }
}

// MARK: - PostCellDelegate
extension ThreadsViewController: PostCellDelegate {
    func openImage(_ image: UIImage) {
        viewModel?.openImage(image)
    }
}

