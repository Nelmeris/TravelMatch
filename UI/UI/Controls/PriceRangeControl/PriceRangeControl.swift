//
//  PriceRangeControl.swift
//  UI
//
//  Created by Maxim Timokhin on 21.07.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

@objc public protocol PriceRangeControlDataSource: class {
    func rangeControl(_ rangeControl: PriceRangeControl, valueForPrice price: Double) -> Int
    func minPrice(in rangeControl: PriceRangeControl) -> Double
    func maxPrice(in rangeControl: PriceRangeControl) -> Double
}

@IBDesignable
public class PriceRangeControl: UIControl {
    
    // MARK: - Input
    @IBOutlet weak var dataSource: PriceRangeControlDataSource?
    
    // MARK: - Props
    @IBInspectable
    public var numberOfBars: Int = 20 {
        didSet {
            setupBars()
        }
    }
    
    @IBInspectable
    public var valueFrom: Double = 60 {
        didSet {
            updateLeftX()
            updateLayers()
        }
    }
    
    @IBInspectable
    public var valueTo: Double = 160 {
        didSet {
            updateRightX()
            updateLayers()
        }
    }
    
    private var bars: [Bar] = [] {
        didSet {
            setupBars()
            updateLayers()
        }
    }

    // MARK: - Config
    
    private var minPrice: Double = 0
    private var maxPrice: Double = 0
    private var minPriceDelta: Double =  5

    private var railHeight: CGFloat = 2
    private var railBottomOffset: CGFloat = 30
    private var handleSize: CGFloat = 12
    
    // MARK: - Layers
    
    private var barLayers = [CAGradientLayer]()
    
    private var railLayer = CALayer()
    
    private var valueLayer = CALayer()
    
    private var leftHandle = CALayer()
    
    private var rightHandle = CALayer()
    
    private var leftLabel = UILabel()
    private var rightLabel = UILabel()
    
    private var leftX: CGFloat = 0
    private var rightX: CGFloat = 0
    
    private var barSize: CGFloat {
        bars.isEmpty ? 0 : bounds.width / (CGFloat(bars.count) * 2)
    }
    
    private var barSpacing: CGFloat {
        bars.isEmpty ? 0 : bounds.width / (CGFloat(bars.count - 1) * 2)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupLayers()
        setupInteraction()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        updateLayers()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        let demoDataSource = DemoPriceDataSource()
        self.dataSource = demoDataSource
        setupLayers()
        reloadData()
    }
    
    // MARK: - Setup
    private func setupLayers() {
        setupRail()
        setupBars()
        setupHandles()
        setupLabels()
    }
    
    private func setupRail() {
        railLayer.backgroundColor = UIColor.ThemeColors
            .blackColor
            .withAlphaComponent(0.6)
            .cgColor
        
        railLayer.removeFromSuperlayer()
        layer.addSublayer(railLayer)
        
        valueLayer.backgroundColor = UIColor.ThemeColors
            .brandBlueColor
            .cgColor
        
        valueLayer.removeFromSuperlayer()
        layer.addSublayer(valueLayer)
    }
    
    private func setupBars() {
        barLayers.forEach { $0.removeFromSuperlayer() }
        barLayers = (0..<numberOfBars).map {_ in
            let bar = CAGradientLayer()
            self.layer.addSublayer(bar)
            return bar
        }
    }
    
    private func setupHandles() {
        [leftHandle, rightHandle].forEach {
            $0.cornerRadius = 4
            $0.backgroundColor = UIColor.ThemeColors.brandBlueColor.cgColor
            $0.removeFromSuperlayer()
            self.layer.addSublayer($0)
        }
    }
    
    private func setupLabels() {
        [leftLabel, rightLabel].forEach {
            $0.font = Font.MontserratRegular.of(size: 10)
            $0.textColor = UIColor.ThemeColors.blackColor
            $0.textAlignment = .center
            self.addSubview($0)
        }
    }
    
    // MARK: - Update
    private func updateLayers() {
        updateRail()
        updateBars()
        updateHandles()
        updateLabels()
    }
    
    private func updateRail() {
        railLayer.frame = CGRect(
            x: 0,
            y: bounds.height - railBottomOffset,
            width: bounds.width,
            height: railHeight
        )
        
        valueLayer.frame = CGRect(
            x: leftX,
            y: bounds.height - railBottomOffset,
            width: rightX - leftX,
            height: railHeight
        )
    }
    
    private func updateBars() {
        guard !bars.isEmpty else { return }
        
        let barMaxHeight = bounds.height - railBottomOffset - 5
        
        let values = bars.map { $0.value }
        
        let maxValue = values.max() ?? 0
        
        for (i, barLayer) in barLayers.enumerated() {
            let bar = bars[i]
            let barX = CGFloat(i) * (barSize + barSpacing)
            
            let barActive = barX >= (leftX - handleSize / 2) && barX <= (rightX + handleSize / 2)
            let barHeight = bar.value > 0
                ? max(barSize, barMaxHeight * CGFloat(Double(bar.value)/Double(maxValue)))
                : 0
            
            barLayer.frame = CGRect(
                x: barX,
                y: bounds.height - barHeight - railBottomOffset - 5,
                width: barSize,
                height: barHeight
            )
            barLayer.cornerRadius = barSize / 2
            
            if barActive {
                barLayer.opacity = 1.0
                barLayer.colors = [
                    UIColor(hexString: "#8CAEE4").cgColor,
                    UIColor(hexString: "#304E7E").cgColor
                ]
            } else {
                barLayer.opacity = 0.4
                barLayer.colors = [
                    UIColor(hexString: "#4B6FA9").cgColor,
                    UIColor(hexString: "#0E1E37").cgColor
                ]
            }
        }
    }
    
    private func updateHandles() {
        guard maxPrice > minPrice else { return }
        leftHandle.frame = CGRect(
            x: max(leftX - handleSize / 2, -(handleSize - barSize) / 2),
            y:  bounds.height - railBottomOffset - handleSize / 2 + railHeight / 2,
            width: handleSize,
            height: handleSize
        )
        
        rightHandle.frame = CGRect(
            x: min(rightX - handleSize / 2, bounds.width - (barSize + handleSize) / 2),
            y:  bounds.height - railBottomOffset - handleSize / 2 + railHeight / 2,
            width: handleSize,
            height: handleSize
        )
    }
    
    private func updateLabels() {
        leftLabel.text = "\(valueFrom) руб"
        leftLabel.sizeToFit()
        
        rightLabel.text = "\(valueTo) руб"
        rightLabel.sizeToFit()
        
        let labelY = bounds.height - railBottomOffset + rightLabel.frame.height
        
        let leftWidth = leftLabel.frame.width
        let rightWidth = rightLabel.frame.width
        
        let leftLabelX = max(
            leftX,
            0
        )
        
        let rightLabelX = min(
            rightX,
            bounds.width - rightWidth
        )
        
        leftLabel.frame = CGRect(
            x: (leftLabelX + leftWidth) > rightLabelX
                ? max(
                    0,
                    min(
                        leftLabelX - leftWidth / 2,
                        bounds.width - rightWidth - leftWidth - 10
                        )
                    )
                : leftX,
            y:  labelY,
            width: leftWidth,
            height: leftLabel.frame.height
        )
        
        rightLabel.frame = CGRect(
            x: rightLabelX < (leftX + leftWidth)
                ? min(
                    bounds.width - rightWidth,
                    leftLabel.frame.minX + leftWidth + 10
                    )
                : rightLabelX,
            y: labelY,
            width: rightWidth,
            height: rightLabel.frame.height
        )
    }
        
    private func updateLeftX() {
        guard maxPrice > minPrice else { return }
        leftX = CGFloat((valueFrom - minPrice) / (maxPrice - minPrice)) * bounds.width
    }

    private func updateRightX() {
        guard maxPrice > minPrice else { return }
        rightX = CGFloat((valueTo - minPrice) / (maxPrice - minPrice)) * bounds.width
    }

    // MARK: - Reload data
    
    public func reloadData() {
        guard let dataSource = dataSource else { return }
        minPrice = dataSource.minPrice(in: self)
        maxPrice = dataSource.maxPrice(in: self)
        
        bars = (0..<numberOfBars).map {
            let price = minPrice + (maxPrice - minPrice) / Double(numberOfBars) * Double($0)
            let value = dataSource.rangeControl(self, valueForPrice: price)
            return Bar(value: value, price: price)
        }
        
        updateLeftX()
        updateRightX()
        updateLayers()
    }
    
    // MARK: - Interaction
    
    private var movingHandle: RangeHandle?
    
    private func setupInteraction() {
        let panGesture = UIPanGestureRecognizer()
        panGesture.addTarget(self, action: #selector(panAction))
        panGesture.delegate = self
        addGestureRecognizer(panGesture)
    }
    
    @objc func panAction(_ recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .began:
            let location = recognizer.location(in: self)
            let leftDistance = abs(leftHandle.frame.minX - location.x)
            let rightDisstance = abs(rightHandle.frame.minX - location.x)
            if leftDistance < rightDisstance {
                movingHandle = .left
            } else {
                movingHandle = .right
            }
        case .cancelled:
            movingHandle = nil
        case .changed:
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            let location = recognizer.location(in: self)
            let newPrice = Double(location.x / bounds.width) * (maxPrice - minPrice) + minPrice
            switch movingHandle {
            case .left:
                valueFrom = max(minPrice, min(valueTo - minPriceDelta, newPrice.rounded()))
                sendActions(for: .valueChanged)
            case .right:
                valueTo = min(maxPrice, max(valueFrom + minPriceDelta, newPrice.rounded()))
                sendActions(for: .valueChanged)
            default:
                break
            }
            CATransaction.commit()
        case .ended:
            movingHandle = nil
        default:
            break
        }
    }
    
}

fileprivate enum RangeHandle {
    case left
    case right
}

fileprivate struct Bar {
    let value: Int
    let price: Double
}

fileprivate class DemoPriceDataSource: PriceRangeControlDataSource {
    
    func rangeControl(_ rangeControl: PriceRangeControl, valueForPrice price: Double) -> Int {
        return Int(sin(price * Double.pi / 180) * 100)
    }
    
    func minPrice(in rangeControl: PriceRangeControl) -> Double {
        return 30
    }
    
    func maxPrice(in rangeControl: PriceRangeControl) -> Double {
        return 170
    }
    
}

extension PriceRangeControl: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
