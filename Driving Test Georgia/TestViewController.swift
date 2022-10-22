import UIKit

class TestViewController: UIViewController {
        
    var imageNames: [String] = []
    private var tickets: [Tickets] = []
    
    @IBOutlet private var bgView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundDesign()
        setupCollectionView()
        loadJSON()
    }
    
    private func backgroundDesign() {
        bgView.backgroundColor = UIColor(red: 69/255.0, green: 43/255.0, blue: 78/255.0, alpha: 1.0)
    }
    
    private func loadJSON() {
        if let url = Bundle.main.url(forResource: "json_file", withExtension: nil) {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let tickets = try jsonDecoder.decode([Tickets].self, from: data)
                self.tickets = tickets
                //print(tickets[1])
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 25
    }
}

extension TestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {
            fatalError()
        }
        
        cell.setup(with: tickets[indexPath.item])
        return cell
    }
}

extension UIViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return collectionView.frame.size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
