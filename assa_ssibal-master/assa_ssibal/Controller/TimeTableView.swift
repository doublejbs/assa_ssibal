

import Foundation
import UIKit


class TimeTableView: UICollectionView {
    let ad = UIApplication.shared.delegate as! AppDelegate
    public var items = [TimeTableItem]() {
        didSet {
            var lastItem = items.last!
            
            if startPoint <= lastItem.startPoint && lastItem.endPoint <= lastItem.endPoint {
                reDrawAllItems()
            }
            
            //시작시간보다 더 작은 시작시간이 들어올경우
            if startPoint > lastItem.startPoint {
                minimumStartPoint = lastItem.startPoint
                startPoint = lastItem.startPoint
            }
            
            //끝나는시간보다 더 큰 끝나는시간이 들어올경우
            if endPoint < lastItem.endPoint {
                maximumEndPoint = lastItem.endPoint
                if lastItem.endMinutes == 0 {
                    lastItem.endMinutes = 59
                    lastItem.endPoint = lastItem.endPoint - 1
                }
                endPoint = lastItem.endPoint
            }
            
            //가장 작은 시작시간을 가지는 과목이 들어올경우
            if minimumStartPoint > lastItem.startPoint {
                minimumStartPoint = lastItem.startPoint
            }
            
            //가장 큰 끝나는시간을 가지는 과목이 들어올경우
            if maximumEndPoint < lastItem.endPoint {
                maximumEndPoint = lastItem.endPoint
            }
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
            
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    var aMinuteHeight:CGFloat {
        get {
            return averageHeight / 60.0
        }
    }
    
    var startPoint: Int = 9 {
        didSet {
            self.numberOfPeriods = self.endPoint - self.startPoint+1
        }
    }
    
    var endPoint: Int = 18 {
        didSet {
            self.numberOfPeriods = self.endPoint - self.startPoint+1
        }
    }
    
    var minimumStartPoint:Int = 25 {
        didSet {
            reDrawAllItems()
        }
    }
    var maximumEndPoint: Int = -1 {
        didSet {
            reDrawAllItems()
        }
    }
    
    public var numberOfDays = 7 {
        didSet {
            self.reloadData()
            // 모든 아이템을 다시 그리자.
            reDrawAllItems()
        }
    }
    
    public var numberOfPeriods = 10 {
        didSet {
            self.reloadData()
            // 모든 아이템을 다시 그리자.
            reDrawAllItems()
        }
    }
    
    public var borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 0.9) {
        didSet {
            self.reloadData()
        }
    }
    
    public var symbolsBgColor = UIColor.clear {
        didSet {
            self.reloadData()
        }
    }
    
    public var borderWidth = CGFloat(0.5) {
        didSet {
            self.reloadData()
        }
    }
    
    public var symbolsFontSize = CGFloat(14) {
        didSet {
            self.reloadData()
        }
    }
    
    public var bgColor = UIColor.white {
        didSet {
            self.backgroundColor = bgColor
        }
    }
    
    public var heightOfWeekdaySymbols = CGFloat(28)
    public var widthOfPeriodSymbols = CGFloat(32)
    var averageHeight: CGFloat {
        get {
            return (self.frame.height - heightOfWeekdaySymbols) / CGFloat(numberOfPeriods)
        }
    }
    var averageWidth: CGFloat {
        get {
            return (self.frame.width - widthOfPeriodSymbols) / numberOfDays.toFloat()
        }
    }
    
    func getItemRect(item: TimeTableItem) -> CGRect {
        let interval:CGFloat = 0.3
        let x = allItemBackgroundRect.origin.x + (CGFloat(item.weekday.hashValue) * averageWidth) + interval
        let y = CGFloat((item.startPoint - self.startPoint)) * averageHeight + allItemBackgroundRect.origin.y + self.aMinuteHeight * CGFloat(item.startMinutes)
        let width = self.averageWidth - (interval * 2)
        // BUG 발생!
        let diff:Int = item.startMinutes > item.endMinutes ? item.endPoint - item.startPoint - 1 : item.endPoint - item.startPoint
        let minute:Int = item.startMinutes > item.endMinutes ? 60 - (item.startMinutes - item.endMinutes) : item.endMinutes - item.startMinutes
        
        let height = (CGFloat(diff) * averageHeight) + (self.aMinuteHeight * minute.toFloat())
        return  CGRect(x: x, y: y, width: width, height: height)
    }
    
    func drawItem(item: TimeTableItem) {
        let view = UIView(frame: getItemRect(item: item))
        view.backgroundColor = item.bgColor
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        /* 레이블을 만든다 */
        let label = UILabel()
        label.frame = view.bounds
        label.text = item.name + "\n" + item.place
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = item.textColor
        label.textAlignment = .center
        label.numberOfLines = 0
        view.addSubview(label)
        addSubview(view)
    }
    
    func reDrawAllItems() {
        // 컬렉션뷰가 아닌 아이템 view들만 다시 그린다.
        for subview in subviews {
            if !(subview is UICollectionView) {
                subview.removeFromSuperview()
            }
        }
        for (_, item) in items.enumerated() {
            drawItem(item: item)
        }
    }
    
    var allItemBackgroundRect: CGRect {
        get {
            let point = CGPoint(x: widthOfPeriodSymbols, y: heightOfWeekdaySymbols)
            let size = CGSize(width: CGFloat(numberOfDays) * averageWidth, height: CGFloat(numberOfPeriods) * averageHeight)
            return CGRect(origin: point, size: size)
            
        }
    }
}


extension Int {
    func toFloat() -> CGFloat {
        return CGFloat(self)
    }
}
