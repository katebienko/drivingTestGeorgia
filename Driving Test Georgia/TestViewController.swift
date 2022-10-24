import UIKit

class TestViewController: UIViewController {
        
    var tickets: [Tickets] = []
    var answersTuples: [(answer: String, correct: Bool)] = []
    var ticketNumber = 0
    var questionAnswers = 0
    
    @IBOutlet private var bgView: UIView!
    @IBOutlet private weak var questionsView: UIView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadJSON()
        setImages()
        designsElements()
    }
    
    private func setImages() {
        imageView.image = UIImage(named: "1.jpg")
    }
    
    private func designsElements() {
        questionsView.layer.cornerRadius = 30
    }
    
    private func loadJSON() {
        if let url = Bundle.main.url(forResource: "json_file", withExtension: nil) {
            do {
                let data = try Data(contentsOf: url)
                let jsonDecoder = JSONDecoder()
                let allTickets = try jsonDecoder.decode([Tickets].self, from: data)
                self.tickets = allTickets
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    @IBAction func nextButtonPress(_ sender: Any) {
        if ticketNumber <= tickets.count {
            questionLabel.text = tickets[ticketNumber].question
            
            answersTuples.removeAll()
            for ans in tickets[ticketNumber].answers {
                answersTuples.append((ans.text, ans.correct))
                tableView.reloadData()
            }
        }

        ticketNumber += 1
    }
}

extension TestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnswersTableViewCell

        //print(answersTuples[indexPath.row].0)
        //print(answersTuples[indexPath.row].1)
        
        if answersTuples.isEmpty {
            cell.answerLabel.text = "empty"
        } else {
            cell.answerLabel.text = (answersTuples[indexPath.row].0)
        }
       
        return cell
    }
}
