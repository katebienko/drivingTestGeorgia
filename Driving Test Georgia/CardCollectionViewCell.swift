import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    var answersArray: [(answer: String, correct: Bool)] = []

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer1: UILabel!
    @IBOutlet weak var answer2: UILabel!
    @IBOutlet weak var answer3: UILabel!
    @IBOutlet weak var answer4: UILabel!
    @IBOutlet weak var viewLabel1: UIView!
    @IBOutlet weak var viewLabel2: UIView!
    @IBOutlet weak var viewLabel3: UIView!
    @IBOutlet weak var viewLabel4: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgStyle()
        
        viewLabel1.layer.cornerRadius = 15
        viewLabel2.layer.cornerRadius = 15
        viewLabel3.layer.cornerRadius = 15
        viewLabel4.layer.cornerRadius = 15
        
        imageView.image = UIImage(named: "1.jpg")
        
        let tap1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap1(_:)))
        viewLabel1.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap2(_:)))
        viewLabel2.addGestureRecognizer(tap2)
        
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap3(_:)))
        viewLabel3.addGestureRecognizer(tap3)
        
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(self.handleTap4(_:)))
        viewLabel4.addGestureRecognizer(tap4)
    }
    
    private func bgStyle() {
        bgView.layer.cornerRadius = 40
        bgView.backgroundColor = UIColor(red: 244/255.0, green: 243/255.0, blue: 241/255.0, alpha: 1.0)
    }
    
    func setup(with tickets: Tickets) {
        for i in 0 ... tickets.answers.count - 1 {
            answersArray.append((tickets.answers[i].text, tickets.answers[i].correct))
        }
        answersArray.shuffle()
        print(answersArray)
        
        question.text = tickets.question
        
        answer1.text = answersArray[0].answer
        answer2.text = answersArray[1].answer
        answer3.text = answersArray[2].answer
    }

    private func answerArray(index: Int, view: UIView) {
        if answersArray[index].correct == true {
            view.backgroundColor = .green
        } else {
            view.backgroundColor = .red
        }
    }
    
    @objc func handleTap1(_ sender: UITapGestureRecognizer? = nil) {
        viewLabel1.isUserInteractionEnabled = false
        viewLabel2.isUserInteractionEnabled = false
        viewLabel3.isUserInteractionEnabled = false
        viewLabel4.isUserInteractionEnabled = false
        
        answerArray(index: 0, view: viewLabel1)
    }
    
    @objc func handleTap2(_ sender: UITapGestureRecognizer? = nil) {
        viewLabel1.isUserInteractionEnabled = false
        viewLabel2.isUserInteractionEnabled = false
        viewLabel3.isUserInteractionEnabled = false
        viewLabel4.isUserInteractionEnabled = false
        
        answerArray(index: 1, view: viewLabel2)
    }
    
    @objc func handleTap3(_ sender: UITapGestureRecognizer? = nil) {
        viewLabel1.isUserInteractionEnabled = false
        viewLabel2.isUserInteractionEnabled = false
        viewLabel3.isUserInteractionEnabled = false
        viewLabel4.isUserInteractionEnabled = false
        
        answerArray(index: 2, view: viewLabel3)
    }
    
    @objc func handleTap4(_ sender: UITapGestureRecognizer? = nil) {
    }
}
