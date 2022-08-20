//
//  StringConstants.swift
//  myGalleryApp
//
//  Created by Alex Krzywicki on 21.08.2022.
//

import Foundation

struct StringConstants {
    // AppDelegate
    static let launchScreen         = "LaunchScreen"
    // HexColor
    static let invalidRed           = "Invalid RED component"
    static let invalidGreen         = "Invalid GREEN component"
    static let invalidBlue          = "Invalid BLUE component"
    // ConnectionService
    static let monitorQueue         = "Monitor"
    // ProfileService
    static let profileKey           = "profile"
    // FavoriteService
    static let favoriteKey          = "favorite"
    // Images
    static let placeholderImage     = "placeholder"
    static let itemSearch           = "item-search"
    static let arrowRightLine       = "arrow-right-line"
    static let showPass             = "show_password"
    static let hidePass             = "hide_password"
    // Alerts
    static let alertTitle           = "Внимание"
    static let alertLogoutBody      = "Вы точно хотите выйти из приложения?"
    static let alertOkButton        = "Да, точно"
    static let alertNoButton        = "Нет"
    static let alertUnfavoriteBody  = "Вы точно хотите удалить из избранного?"
    // Warning banners
    static let warningLogoutFail    = "Не удалось выйти, попробуйте еще раз"
    static let warningNoConnection  = "Отсутствует интернет соединение \n Попробуйте позже"
    static let warningEmptyField    = "Поле не может быть пустым"
    static let warningWrongLogin    = "Логин или пароль введены не правильно"
    // ProfileView
    static let profileTitle         = "Профиль"
    static let profileCity          = "Город"
    static let profilePhone         = "Телефон"
    static let profileEmail         = "Почта"
    // FavoriteView
    static let favoriteTitle        = "Избранное"
    static let favoriteEmptyState   = "Нет избранных элементов"
    // MainView
    static let mainEmptyState       = "Не удалось загрузить ленту \n Обновите экран или попробуйте позже"
    static let mainTitle            = "Главная"
    // SearchView
    static let searchEmptyState     = "По этому запросу нет результатов, \n попробуйте другой запрос"
    static let searchPlaceholder    = "Поиск"
    // LoginView
    static let loginTitle           = "Вход"
    static let loginLabel           = "Логин"
    static let passLabel            = "Пароль"
    
    
}
