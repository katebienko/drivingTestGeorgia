import UIKit

class TestViewController: UIViewController {
        
    var tickets: [Tickets] = []
    var answersTuples: [(answer: String, correct: Bool)] = []
    var ticketNumber = 0
    
    @IBOutlet private var bgView: UIView!
    @IBOutlet private weak var questionsView: UIView!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadJSON()
        designsElements()
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
        tableView.allowsSelection = true
        
        ticketNumber += 1
        if ticketNumber <= tickets.count - 1 {
            tableView.reloadData()
            answersTuples.removeAll()
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
}

extension TestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tickets[ticketNumber].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnswersTableViewCell

        cell.answerLabel.textColor = .black
        cell.viewAnswerBg.backgroundColor = .white
        cell.answerLabel.attributedText = nil
        
        answersTuples.append((tickets[ticketNumber].answers[indexPath.row].text,tickets[ticketNumber].answers[indexPath.row].correct))
        
        if ticketNumber <= tickets.count - 1 {
            questionLabel.text = tickets[ticketNumber].question
            imageView.image = UIImage(named: "\(String(describing: tickets[ticketNumber].image))")
        }

        cell.answerLabel.text = (answersTuples[indexPath.row].0)
        cell.selectionStyle = .none
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AnswersTableViewCell
        
        switch answersTuples[indexPath.row].1 {
        
        case true:
            cell.viewAnswerBg.backgroundColor = UIColor(red: 9.0/255.0, green: 22.0/255.0, blue: 40.0/255.0, alpha: 1.0)
            cell.answerLabel.textColor = .white
            tableView.allowsSelection = false
            
        case false:
            cell.answerLabel.attributedText = answersTuples[indexPath.row].0.strikeThrough()
            tableView.allowsSelection = false
        }
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        
        return attributeString
    }
}
