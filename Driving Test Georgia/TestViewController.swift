import UIKit

class TestViewController: UIViewController {
        
    var tickets: [Tickets] = []
    var answersTuples: [(answer: String, correct: Bool)] = []
    var ticketNumber = 0
    var count = 0
    var correctAnswer: [(answer: String, correct: Bool)] = []
    var indexCorrectAnswer: Int = 0
    var mistakes: Int = 0
    
    @IBOutlet private weak var mistakesLabel: UILabel!
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
        buttonDesign()
    }
    
    private func buttonDesign() {
        nextButton.backgroundColor = UIColor(red: 251.0/255.0, green: 224.0/255.0, blue: 94.0/255.0, alpha: 1.0)
        nextButton.layer.cornerRadius = nextButton.frame.height / 2
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
    
    private func showAlert() {
        if mistakes == 4 {
            let alert = UIAlertController(title: "Тест не пройден!",
                                          message: "Вы допустили больше трех ошибок. Попробуйте еще раз!",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "На главную", style: .cancel, handler: { _ in
                self.navigationController?.popToRootViewController(animated: true)
            }))
    
            present(alert, animated: true)
        }
    }
    
    @IBAction func nextButtonPress(_ sender: Any) {
        showAlert()
           
        tableView.allowsSelection = true
        
        ticketNumber += 1
        count += 1
        
        if ticketNumber <= tickets.count - 1 {
            tableView.reloadData()
            answersTuples.removeAll()
            correctAnswer.removeAll()
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
        cell.selectionStyle = .none
        
        nextButton.alpha = 0.5
        nextButton.isEnabled = false
        
        questionCountLabel.text = "\(count)/30"
        mistakesLabel.text = "Ошибок: \(mistakes)"

        if ticketNumber <= tickets.count - 1 {
            questionLabel.text = tickets[ticketNumber].question
            imageView.image = UIImage(named: "\(tickets[ticketNumber].image ?? "hover.jpg")")
            
            //add to array of tuples answers and correct or not
            answersTuples.append((
                tickets[ticketNumber].answers[indexPath.row].text,
                tickets[ticketNumber].answers[indexPath.row].correct
            ))
            
            if tickets[ticketNumber].answers[indexPath.row].correct == true {
                correctAnswer.append((
                    tickets[ticketNumber].answers[indexPath.row].text,
                    tickets[ticketNumber].answers[indexPath.row].correct
                ))
                
                indexCorrectAnswer = indexPath.row
            }
            
            // КРАШИТСЯ - обновляется tableView если из видимости уходит cell
            cell.answerLabel.text = (answersTuples[indexPath.row].0)
        }

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
            mistakes += 1
            
            cell.answerLabel.attributedText = answersTuples[indexPath.row].0.strikeThrough()
            
            tableView.allowsSelection = false

            //show correct answer
            let indexPathForCorAnswer = IndexPath(row: indexCorrectAnswer, section: 0)
            let currentCell = tableView.cellForRow(at: indexPathForCorAnswer) as! AnswersTableViewCell
            currentCell.viewAnswerBg.backgroundColor = UIColor(red: 9.0/255.0, green: 22.0/255.0, blue: 40.0/255.0, alpha: 1.0)
            currentCell.answerLabel.textColor = .white
            
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
