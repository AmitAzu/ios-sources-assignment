
//  Copyright © 2018 Chegg. All rights reserved.

import UIKit
import Combine
import SwiftUI

class HomeScreenVC: UIViewController {

    let homeVM: HomeViewModel
    
    init(homeVM: HomeViewModel) {
        self.homeVM = homeVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        addHostingController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func addHostingController() {
        let hostingController = UIHostingController(rootView: HomeScreen(viewModel: homeVM))
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.didMove(toParent: self)
    }
}

