import UIKit

class ViewController: UIViewController {
    
    var allQuestions: [String] = []

    @IBOutlet private weak var viewCategoryBB1: UIView!
    @IBOutlet private var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDesignViews()
        tapViewCategoryBB1()
    }
    
    private func tapViewCategoryBB1() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewCategoryBB1.isUserInteractionEnabled = true
        viewCategoryBB1.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
       
        if let testViewController = storyboard.instantiateViewController(identifier: "TestViewController") as? TestViewController {
            testViewController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(testViewController, animated: true)
        }
    }
    
    private func setDesignViews() {
        viewCategoryBB1.layer.cornerRadius = 30
    }
}

