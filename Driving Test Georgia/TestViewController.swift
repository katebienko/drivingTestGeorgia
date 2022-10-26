import UIKit

class TestViewController: UIViewController {
        
    var tickets: [Tickets] = []
    var answersTuples: [(answer: String, correct: Bool)] = []
    var ticketNumber = 0
    var count = 0
    
    @IBOutlet private weak var questionCountLabel: UILabel!
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
        
        nextButton.backgroundColor = UIColor(red: 251.0/255.0, green: 224.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
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
                self.tickets.shuffle()
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    @IBAction func nextButtonPress(_ sender: Any) {
        tableView.allowsSelection = true
        
        ticketNumber += 1
        count += 1
        
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

        //show normal cell without effects
        cell.answerLabel.textColor = .black
        cell.viewAnswerBg.backgroundColor = .white
        cell.answerLabel.attributedText = nil
        cell.selectionStyle = .none
        
        //count questions left
        questionCountLabel.text = "\(count)/30"
        
        //show not active button
        nextButton.alpha = 0.66
        nextButton.isEnabled = false
        
        if ticketNumber <= tickets.count - 1 {
            questionLabel.text = tickets[ticketNumber].question
            imageView.image = UIImage(named: "\(tickets[ticketNumber].image ?? "hover.jpg")")
            
            //add to array of tuples answers and correct or not
            answersTuples.append((
                tickets[ticketNumber].answers[indexPath.row].text,
                tickets[ticketNumber].answers[indexPath.row].correct
            ))
        }

        cell.answerLabel.text = (answersTuples[indexPath.row].0)
 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AnswersTableViewCell
        
        switch answersTuples[indexPath.row].1 {
        
        case true:
            cell.viewAnswerBg.backgroundColor = UIColor(red: 9.0/255.0, green: 22.0/255.0, blue: 40.0/255.0, alpha: 1.0)
            cell.answerLabel.textColor = .white
            
            tableView.allowsSelection = false
            
            nextButton.alpha = 1
            nextButton.isEnabled = true
            
        case false:
            cell.answerLabel.attributedText = answersTuples[indexPath.row].0.strikeThrough()
            
            tableView.allowsSelection = false
            
            nextButton.alpha = 1
            nextButton.isEnabled = true
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
