//
//  SceneCoordinator.swift
//  Unsplasher
//
//  Created by David on 2018/3/10.
//  Copyright © 2018年 David. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SceneCoordinator: SceneCoordinatorType {

  fileprivate var window: UIWindow
  fileprivate var currentViewController: UIViewController

  required init(window: UIWindow) {
    self.window = window // store the ref to window
    // window that appdelegate gave us at first will have a root vc on default
    // root vc won't be nil
    currentViewController = window.rootViewController!
  }

  static func actualViewController(for viewController: UIViewController) -> UIViewController {
    // get actual vc if given vc is a navigation controller
    if let navigationController = viewController as? UINavigationController {
      // return navigation controller's root view
      return navigationController.viewControllers.first!
    } else {
      return viewController
    }
  }

  @discardableResult
  func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
    let subject = PublishSubject<Void>()
    let viewController = scene.viewController()
    
    switch type { // switch through transition type
    case .root:
      // if transit to root, get actual vc for vc, then set it to root
      currentViewController = SceneCoordinator.actualViewController(for: viewController)
      window.rootViewController = viewController // make it root
      subject.onCompleted() // then complete this subject.
      
    case .push:
      guard let navigationController = currentViewController.navigationController else {
        fatalError("Can't push a view controller without a current navigation controller")
      }
      
      _ = navigationController.rx.delegate
        // one-off subscription to be notified when push complete
        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
        // send nothing to subject to emit on next. (just a notify)
        .map { _ in }
        .bind(to: subject)
      navigationController.pushViewController(viewController, animated: true)
      // TODO: figure out what's going on here
      currentViewController = SceneCoordinator.actualViewController(for: viewController)
      
    case .modal:
      currentViewController.present(viewController, animated: true, completion: {
        subject.onCompleted() // on ref-count here, don't need weak or unowned
      })
      // no navigation controller when present modally, just return viewController itself
      currentViewController = SceneCoordinator.actualViewController(for: viewController)
    }
    
    return subject.asObservable()
      .take(1) // take at most 1 emitted element
      .ignoreElements()
      // ignoreElements here will just forwar complete event from take 1.
      // won't forward elements emitted by take 1
  }

  @discardableResult
  func pop(animated: Bool) -> Completable {
    let subject = PublishSubject<Void>()
    
    if let presenter = currentViewController.presentingViewController {
      // this is a modal, dismiss it
      currentViewController.dismiss(animated: animated, completion: {
        // dismiss back to previous vc
        // set current vc to back to the view controller which presenting currentViewController
        self.currentViewController = SceneCoordinator.actualViewController(for: presenter)
        subject.onCompleted()
      })
    } else if let navigationController = currentViewController.navigationController {
      _ = navigationController.rx.delegate
        .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
        .map { _ in }
        .bind(to: subject)
      guard navigationController.popViewController(animated: true) != nil else {
        fatalError("can't navigate back from \(currentViewController)")
      }
      currentViewController = SceneCoordinator.actualViewController(for: navigationController.topViewController!)
    } else {
      fatalError("unable to push back...")
    }
    
    return subject.asObservable()
      .take(1)
      .ignoreElements()
  }

}

