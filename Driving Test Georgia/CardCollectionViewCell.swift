import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    var answersArray: [(answer: String, correct: Bool)] = []

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var answer2: UILabel!
    @IBOutlet weak var answer3: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 40
        bgView.backgroundColor = UIColor(red: 244/255.0, green: 243/255.0, blue: 241/255.0, alpha: 1.0)
    }
    
    func setup(with tickets: Tickets) {
        for i in 0 ... tickets.answers.count - 1 {
            answersArray.append((tickets.answers[i].text, tickets.answers[i].correct))
        }
        answersArray.shuffle()
        //print(answersArray)
        
        question.text = tickets.question
        
        answer1.text = answersArray[0].answer
        answer2.text = answersArray[1].answer
        answer3.text = answersArray[2].answer
    }
}
