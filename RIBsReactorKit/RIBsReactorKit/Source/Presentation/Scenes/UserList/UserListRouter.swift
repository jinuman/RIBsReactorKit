//
//  UserListRouter.swift
//  RIBsReactorKit
//
//  Created by Elon on 2020/05/02.
//  Copyright © 2020 Elon. All rights reserved.
//

import RIBs

// MARK: - UserListInteractable

protocol UserListInteractable:
  Interactable,
  UserInformationListener
{
  var router: UserListRouting? { get set }
  var listener: UserListListener? { get set }
}

protocol UserListViewControllable: ViewControllable {}

// MARK: - UserListRouter

final class UserListRouter:
  ViewableRouter<UserListInteractable, UserListViewControllable>,
  UserListRouting
{

  private let userInformationBuilder: UserInformationBuilder
  private var userInformationRouter: UserInformationRouting?

  // MARK: - Initialization & Deinitialization

  init(
    userInformationBuilder: UserInformationBuilder,
    interactor: UserListInteractable,
    viewController: UserListViewControllable
  ) {
    self.userInformationBuilder = userInformationBuilder
    super.init(interactor: interactor, viewController: viewController)
    interactor.router = self
  }

  //// FIXME: - fix after implementation UserInformationRIB  2020-06-23 23:57:29
  func attachUserInformationRIB() {
    let router = userInformationBuilder.build(withListener: interactor)
    userInformationRouter = router
    attachChild(router)
    viewController.present(router.viewControllable)
  }

  //// FIXME: - fix after implementation UserInformationRIB  2020-06-23 23:57:29
  func detachUserInformationRIB() {
    guard let router = userInformationRouter else { return }
    detachChild(router)
    viewController.dismiss(router.viewControllable)
    userInformationRouter = nil
  }
}
