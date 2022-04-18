//
//  HmKingFisherVC.swift
//  SwiftUtil
//
//  Created by 侯猛 on 2022/3/16.
//

import Kingfisher
import UIKit

class HmKingFisherVC: HmBaseViewController {
    private let mainScrollView = UIScrollView()
    private let mainContainer = UIStackView()

    private let imageView_1 = UIImageView()
    private let imageView_2 = UIImageView()

    override func addCustomControl() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainContainer)
        mainContainer.addArrangedSubview(imageView_1)
        mainContainer.addArrangedSubview(imageView_2)
    }
    
    override func setupCustomControlStyle() {
        imageView_1.contentMode = .scaleAspectFit
        imageView_2.contentMode = .scaleAspectFit
        mainContainer.axis = .vertical
        mainContainer.spacing = 20
        mainContainer.alignment = .center
    }

    /// 添加约束
    override func addCustomConstraint() {
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainContainer.snp.makeConstraints { make in
            make.edges.width.equalToSuperview()
        }
        imageView_1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        imageView_2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
    }

    /// 绑定 处理
    override func bindHandler() {
        imageView_1
            .kf
            .setImage(
                with: URL(string: "https://dev-img-1303824005.cos.ap-beijing.myqcloud.com/img/f754452a-f03a-4c15-b6bd-60cdefc0add6.gif"),
                options: [
//                    .onlyLoadFirstFrame
                ]
            )
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: { [self] in
            imageView_2
                .kf
                .setImage(
                    with: URL(string: "https://dev-img-1303824005.cos.ap-beijing.myqcloud.com/img/f754452a-f03a-4c15-b6bd-60cdefc0add6.gif"),
                    options: [
                        .onlyLoadFirstFrame
                    ]
                )
        })
        
    }
}
