//
//  ScrollView.swift
//  UI
//
//  Created by Artem Kufaev on 04.08.2020.
//  Copyright © 2020 Maxim Timokhin. All rights reserved.
//

import UIKit

public class ScrollView: UIScrollView {
    
    /// Сдвигает контент по высоте выдвигаемой клавиатуры
    /// - Parameter keyboardNotification: Клавиатурное уведомление
    public func shiftContent(of keyboardNotification: Notification) {
        guard let keyboardFrame = KeyboardHelper.parseFrame(from: keyboardNotification) else { return }
        
        switch keyboardNotification.name {
        case UIResponder.keyboardWillHideNotification:
            // Сброс при скрытии клавиатуры
            contentInset = .zero
        default:
            // Отступ от нижнего края
            let bottomInset = frame.maxY - keyboardFrame.minY
            guard bottomInset > 0 else { return }
            contentInset = UIEdgeInsets(top: 0, left: 0, bottom: bottomInset, right: 0) // Отступ от нижнего края
        }
    }
    
    
    /// Фокусирование на указываемой позиции. Если по заданной позиции скролл не может прокрутить,
    /// он прилипает к одному из краев
    /// - Parameters:
    ///   - yPosition: Позиция для фокусирования
    ///   - animated: Анимирование процесса
    public func focusing(on yPosition: CGFloat, animated: Bool) {
        let height = frame.height - contentInset.bottom - contentInset.top // Видимая высота с учетом инсетов
        
        var centeringPoint: CGPoint?
        if yPosition - height / 2 < 0 { // Если выходит за границу сверху
            centeringPoint = .zero
        } else if yPosition + height / 2 > contentSize.height { // Если выходит за границу снизу
            centeringPoint = CGPoint(x: 0, y: contentSize.height - height)
        } else { // Центрирование на элементе
            centeringPoint = CGPoint(x: 0, y: yPosition - height / 2)
        }
        
        guard contentOffset != centeringPoint else { return } // Защита от повторного центрирования
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.contentOffset = centeringPoint!
            }
        } else {
            contentOffset = centeringPoint!
        }
    }
    
}
