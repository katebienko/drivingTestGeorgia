import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    var answersArray: [(question: String, correct: Bool)] = []

    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UILabel!    
    @IBOutlet weak var answer3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(with tickets: Tickets) {
        for i in 0 ... tickets.answers.count - 1 {
            answersArray.append((tickets.answers[i].text, tickets.answers[i].correct))
        }
        answersArray.shuffle()
        print(answersArray)
        
        question.text = tickets.question
        answer1.setTitle(answersArray[0].question, for: .normal)
        answer2.text = answersArray[1].question
        answer3.text = answersArray[2].question
    }
    
    @IBAction func answerTap(_ sender: Any) {
        if answersArray[0].correct == true {
            answer1.backgroundColor = .green
        } else {
            answer1.backgroundColor = .red
        }
    }
}
