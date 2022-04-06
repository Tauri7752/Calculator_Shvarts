//
//  ViewController.swift
//  Calculator
//
//  Created by Ростислав Скрипников on 21.12.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var holder: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    var firstNumber = 0
        var resultNumber = 0
        var currentOperation: Operation?
          enum Operation {
          case add, subtract, multiply, divide
            }
    private var resultLable: UILabel = {
            let label = UILabel()
            label.text = "0"
            label.textColor = .white
            label.textAlix  gnment = .right
            label.font = UIFont(name: "Helvetica", size: 100)
        return label
    }()
    
    private func setupNumberPad() {
                let FontSize:CGFloat = 25
                // стандартный размер шрифта в дробных числах
                let buttonSize: CGFloat = view.frame.size.width / 4
                // размер кнопки в 1/4
                let zeroButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-buttonSize, width: buttonSize*3, height: buttonSize))
                // в UIButton мы задаем позицию нашей кнопки
                zeroButton.setTitleColor(.black, for: .normal)
                // задаем цвет нашей кнопки
                zeroButton.backgroundColor = .white
                // кнопка будет белая
                zeroButton.setTitle("0", for: .normal)
                // ее контент конечно 0
                zeroButton.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize)
                // шрифт, family и размер текста
                zeroButton.tag = 1
                // по тегу мы потом будем обрабатывать нажатие на кнопку
                holder.addSubview(zeroButton)  // добавляем в наш holder кнопку
                zeroButton.addTarget(self, action: #selector(zeroTapped), for: .touchUpInside)
                // добавляем функцию обработчик и на каком событии
            for x in 0..<3 {
                      let button_row_1 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*2), width: buttonSize, height: buttonSize))
                      //будем использовать наш x и для положения по x
                      button_row_1.setTitleColor(.black, for: .normal) //цвет
                      button_row_1.backgroundColor = .white //задний цвет
                      button_row_1.setTitle("\(x+1)", for: .normal) // задаем содержание
                      holder.addSubview(button_row_1) // добавляем в наш вид
                      button_row_1.tag = x+2 // т.к.тег 1 уже занят, добавляем по 2
                      button_row_1.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                      //добавляем обработчик
                  }
            for x in 0..<3 {
                      let button_row_2 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*3), width: buttonSize, height: buttonSize))
                      button_row_2.setTitleColor(.black, for: .normal)
                      button_row_2.backgroundColor = .white
                      button_row_2.setTitle("\(x+4)", for: .normal)
                      holder.addSubview(button_row_2)
                      button_row_2.tag = x+5
                      button_row_2.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                  }
                  
                  for x in 0..<3 {
                      let button_row_3 = UIButton(frame: CGRect(x: buttonSize * CGFloat(x), y: holder.frame.size.height-(buttonSize*4), width: buttonSize, height: buttonSize))
                      button_row_3.setTitleColor(.black, for: .normal)
                      button_row_3.backgroundColor = .white
                      button_row_3.setTitle("\(x+7)", for: .normal)
                      holder.addSubview(button_row_3)
                      button_row_3.tag = x+8
                      button_row_3.addTarget(self, action: #selector(numberPressed(_:)), for: .touchUpInside)
                  }
            let clearButton = UIButton(frame: CGRect(x: 0, y: holder.frame.size.height-(buttonSize*5), width: view.frame.size.width - buttonSize, height: buttonSize))
                    clearButton.setTitleColor(.black, for: .normal)
                    clearButton.backgroundColor = .init(red: 0, green: 2, blue: 0.8, alpha: 1) // здесь я задаю цвета с помощью rgb
                     clearButton.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize-4) //хочу кнопку СЕ довольно большого размера
                    clearButton.setTitle("CE", for: .normal)
                    holder.addSubview(clearButton) // добавляем кнопку в наш holder
                    clearButton.addTarget(self, action: #selector(clearResult), for: .touchUpInside) //добавляем функцию обработчик
            let operations = ["=","+", "-", "x", "÷"] //массив наших операндов
     
                    for x in 0..<5 {
                        let button_operand = UIButton(frame: CGRect(x: buttonSize * 3, y: holder.frame.size.height-(buttonSize * CGFloat(x+1)), width: buttonSize, height: buttonSize))
                        button_operand.setTitleColor(.black, for: .normal)
                        button_operand.backgroundColor = .init(red: 2, green: 0.8, blue: 0, alpha: 1) //желтый цвет
                        button_operand.setTitle(operations[x], for: .normal)
                        holder.addSubview(button_operand)
                        button_operand.tag = x+1
                        //добавляем тэги, чтобы потом можно было на них ориентироватьсят
                        button_operand.titleLabel?.font = UIFont(name: "Helvetica", size: FontSize)
                        button_operand.addTarget(self, action: #selector(operationPressed(_:)), for: .touchUpInside)
                    }
            resultLabel.frame = CGRect(x: 20, y: clearButton.frame.origin.y - 110.0, width: view.frame.size.width - 40, height: 100)
               holder.addSubview(resultLabel)
           }
    @objc func clearResult(){
        resultLable.text = "0"
        currentOperation = nil
        firstNumber = 0
    }
    @objc func zeroTapped(){
        if resultLable.text != "0"{
            if let text = resultLable.text {
                resultLable.text = "\(text)\(0)"
            }
        }
    }

    @objc func numberPressed(_ sender: UIButton){
        let tag = sender.tag - 1
        
        if resultLable.text == "0"{
            resultLable.text = "\(tag)"
        }
        else if let text = resultLable.text{
            resultLable.text = "\(text)\(tag)"
        }
    }
    @objc func operationPressed(_ sender: UIButton) {
                let tag = sender.tag
                
                if let text = resultLabel.text, let value = Int(text), firstNumber == 0 {
                    //тоже используем опциональное связывание
                    firstNumber = value
                    resultLabel.text = "0"
                }
                
                if tag == 1 {
                    if let operation = currentOperations {
                        var secondNumber = 0
                        if let text = resultLabel.text, let value = Int(text) {
                            secondNumber = value
                        }
                        
                        switch operation {
                        case .add:
                            
                            firstNumber = firstNumber + secondNumber
                            secondNumber = 0 //обнуляем второе число
                            resultLabel.text = "\(firstNumber)"
                            currentOperations = nil
                            firstNumber = 0 //и первое после записи в Label тоже
                            
                            break
                            
                        case .subtract:
                            firstNumber = firstNumber - secondNumber
                            secondNumber = 0
                            resultLabel.text = "\(firstNumber)"
                            currentOperations = nil
                            firstNumber = 0
                            
                            break
                            
                        case .multiply:
                            firstNumber = firstNumber * secondNumber
                            secondNumber = 0
                            resultLabel.text = "\(firstNumber)"
                            currentOperations = nil
                            firstNumber = 0
                            
                            break
                            
                        case .divide:
                            firstNumber = firstNumber / secondNumber
                            secondNumber = 0
                            resultLabel.text = "\(firstNumber)"
                            currentOperations = nil
                            firstNumber = 0
                            break
                        }
                    }
                }
                else if tag == 2 {
                    currentOperations = .add
                    // назначаем операции по номер лейблов. Если будете перемещать кнопки, не забудьте поменять здесь
                }
                else if tag == 3 {
                    currentOperations = .subtract
                }
                else if tag == 4 {
                    currentOperations = .multiply
                }
                else if tag == 5 {
                    currentOperations = .divide
                }
            }

}

