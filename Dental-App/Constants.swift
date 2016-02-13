//
//  Constants.swift
//  Dental-App
//
//  Created by Cristian Duguet on 7/15/15.
//  Copyright (c) 2015 Cristian Duguet. All rights reserved.
//

import Foundation

/* TODO: Try struct format for constants */
struct Constants {
    struct PF {
        struct Installation {
            static let ClassName = "_Installation"
        }
    }
}

//let HEXCOLOR(c) = [UIColor colorWithRed:((c>>24)&0xFF)/255.0 green:((c>>16)&0xFF)/255.0 blue:((c>>8)&0xFF)/255.0 alpha:((c)&0xFF)/255.0]


// azul facebook #0066cc
// verde correo #339966
// botn entrar #00cc99
// cepillo Dientes #3399ff
// hilo dental #33cc99
// reloj celeste #3399ff




let DEFAULT_TAB							= 0

/* Design */
let BUTTONS_CORNER_RADIUS               = 10  as CGFloat            //  CGFloat

/* Installation */
let PF_INSTALLATION_CLASS_NAME			= "_Installation"           //	Class name
let PF_INSTALLATION_OBJECTID			= "objectId"				//	String
let PF_INSTALLATION_USER				= "user"					//	Pointer to User Class

/* User */
let PF_USER_PERMISSIONS                 = ["public_profile", "email", "user_friends"] //String Array, permissions for facebook
let PF_USER_CLASS_NAME					= "User"                   //	Class name
let PF_USER_OBJECTID					= "objectId"				//	String
let PF_USER_USERNAME					= "username"				//	String
let PF_USER_CONTACTEMAIL                = "contactEmail"            // String
let PF_USER_PASSWORD					= "password"				//	String
let PF_USER_EMAIL						= "email"                   //	String
let PF_USER_EMAILCOPY					= "emailCopy"               //	String
let PF_USER_FIRSTNAME                   = "firstname"                //  String
let PF_USER_LASTNAME                    = "lastname"                //  String
let PF_USER_FULLNAME					= "fullname"				//	String
let PF_USER_FULLNAME_LOWER				= "fullname_lower"          //	String
let PF_USER_FACEBOOKID					= "facebookId"              //	String
let PF_USER_PICTURE						= "picture"                 //	File
let PF_USER_THUMBNAIL					= "thumbnail"               //	File
let PF_USER_ACTIVATED                   = "activated"               //  Boolean

/* Alarm */
let PF_ALARM_CLASS_NAME                 = "Alarm"                   // Class Name
let PF_ALARM_ID                         = "UUID"                    // String
let PF_ALARM_TITLE                      = "title"                   // String
let PF_ALARM_TIME                       = "time"                    // NSDate

/* Groups */
let PF_GROUPS_CLASS_NAME				= "Groups"                  //	Class name
let PF_GROUPS_NAME                      = "name"					//	String

/* Messages*/
let PF_MESSAGES_CLASS_NAME				= "Messages"				//	Class name
let PF_MESSAGES_USER					= "user"					//	Pointer to User Class
let PF_MESSAGES_GROUPID					= "groupId"                 //	String
let PF_MESSAGES_DESCRIPTION				= "description"             //	String
let PF_MESSAGES_LASTUSER				= "lastUser"				//	Pointer to User Class
let PF_MESSAGES_LASTMESSAGE				= "lastMessage"             //	String
let PF_MESSAGES_COUNTER					= "counter"                 //	Number
let PF_MESSAGES_UPDATEDACTION			= "updatedAction"           //	Date

/* Notification */
let NOTIFICATION_APP_STARTED			= "NCAppStarted"
let NOTIFICATION_USER_LOGGED_IN			= "NCUserLoggedIn"
let NOTIFICATION_USER_LOGGED_OUT		= "NCUserLoggedOut"