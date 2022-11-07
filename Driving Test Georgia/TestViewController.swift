import UIKit

class TestViewController: UIViewController {
        
    var tickets: [Tickets] = []
    var answersTuples: [(answer: String, correct: Bool)] = []
    var ticketNumber = 0
    var count = 0
    var correctAnswer: [(answer: String, correct: Bool)] = []
    var indexCorrectAnswer: Int = 0
    var mistakes: Int = 0
    var strokeCellIndex: Int? = nil
    
    @IBOutlet private var bgView: UIView!
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var questionsView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var nextButton: UIButton!
    @IBOutlet private weak var mistakesLabel: UILabel!
    @IBOutlet private weak var questionCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.backgroundColor =  UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        
        questionsView.backgroundColor = UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        textView.textColor = .black
        questionCountLabel.textColor = .black
       
        tableView.delegate = self
        tableView.dataSource = self
        
        loadJSON()
        fullAnswerTuples()
        buttonDesign()
        buttonCondition(isActive: false)
    }
    
    private func fullAnswerTuples() {
        if ticketNumber < tickets.count {
            textView.text = tickets[ticketNumber].question
            imageView.image = UIImage(named: "\(tickets[ticketNumber].image ?? "hover.jpg")")

            for i in 0 ..< tickets[ticketNumber].answers.count  {
                answersTuples.append((
                    tickets[ticketNumber].answers[i].text,
                    tickets[ticketNumber].answers[i].correct
                ))

                if tickets[ticketNumber].answers[i].correct == true {
                    correctAnswer.append((
                        tickets[ticketNumber].answers[i].text,
                        tickets[ticketNumber].answers[i].correct
                    ))

                    indexCorrectAnswer = i
                    print("Номер вопроса: \(tickets[ticketNumber].number) ------- Правильный ответ: \(indexCorrectAnswer)")

                }
            }
        }
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
        let alert = UIAlertController(title: "Тест не пройден!",
                                      message: "Вы допустили больше трех ошибок. Попробуйте еще раз!",
                                      preferredStyle: .alert)
            
        alert.addAction(UIAlertAction(title: "На главную", style: .cancel, handler: { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        present(alert, animated: true)
    }
    
    private func buttonCondition(isActive: Bool) {
        if isActive == true {
            nextButton.alpha = 1
            nextButton.isEnabled = true
        } else {
            nextButton.alpha = 0.5
            nextButton.isEnabled = false
        }
    }
    
    @IBAction func nextButtonPress(_ sender: Any) {
        if mistakes == 5 {
            showAlert()
        }
        
        buttonCondition(isActive: false)
         
        count += 1
        ticketNumber += 1
        
        questionCountLabel.text = "\(count)/30"
        mistakesLabel.text = "Ошибок: \(mistakes)"
        
        if ticketNumber < tickets.count {
            answersTuples.removeAll()
            correctAnswer.removeAll()
            fullAnswerTuples()
           
            strokeCellIndex = nil
            tableView.allowsSelection = true
            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            tableView.reloadData()
        } else {
            print("закончились вопросики")
        }
    }
}

extension TestViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tickets[ticketNumber].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AnswersTableViewCell

        if strokeCellIndex != nil {
            if indexPath.row == strokeCellIndex! {
               // cell.answerLabel.attributedText = answersTuples[indexPath.row].answer.strikeThrough()
                cell.answerLabel.textColor = .red
            } else {
               // cell.answerLabel.attributedText = nil
            }
        } else {
            cell.answerLabel.textColor = .black
            cell.viewAnswerBg.backgroundColor = .white
            cell.answerLabel.attributedText = nil
            cell.selectionStyle = .none
        }

        cell.answerLabel.text = (answersTuples[indexPath.row].answer)
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AnswersTableViewCell

        switch answersTuples[indexPath.row].correct {
        
        case true:
            buttonCondition(isActive: true)
            
            cell.viewAnswerBg.backgroundColor = UIColor(red: 9.0/255.0, green: 22.0/255.0, blue: 40.0/255.0, alpha: 1.0)
            cell.answerLabel.textColor = .white
            
            tableView.allowsSelection = false
            
        case false:
            tableView.allowsSelection = false
            buttonCondition(isActive: true)
            mistakes += 1
            
            //cell.answerLabel.attributedText = answersTuples[indexPath.row].answer.strikeThrough()
            cell.answerLabel.textColor = .red
            strokeCellIndex = indexPath.row
            
            if let currentCell = tableView.cellForRow(at: IndexPath(row: indexCorrectAnswer, section: 0)) as? AnswersTableViewCell {
                currentCell.viewAnswerBg.backgroundColor = UIColor(red: 9.0/255.0, green: 22.0/255.0, blue: 40.0/255.0, alpha: 1.0)
                currentCell.answerLabel.textColor = .white
            }
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
