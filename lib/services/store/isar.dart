// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:isar/isar.dart';
//
// import '../models/authorization.dart';
// import '../models/contact.dart';
//
// Future<Isar> openIsar(String path) async {
//   Directory? dir;
//
//   if (!kIsWeb) {
//     dir = Directory.current;
//   }
//   var fullPath = (!kIsWeb ? dir!.path : ' ') + path;
//
//   return await Isar.open([ContactSchema, AuthorizationSchema],
//       directory: fullPath);
// }
//
// class IsarStore {
//   Isar? isar;
//
//   static IsarStore? _instance;
//
//   // 私有的命名构造函数
//   IsarStore._internal();
//
//   static Future<IsarStore> _getInstance() async {
//     if (_instance == null) {
//       var instance = IsarStore._internal();
//       instance.isar = await openIsar('/articles');
//       _instance = instance;
//     }
//     return _instance!;
//   }
//
//   static Future<void> insert() async {
//     var instance = await _getInstance();
//     final contact = Contact()..name = "My first contact";
//
//     await instance.isar?.writeTxn(() async {
//       contact.id = await instance.isar!.contacts.put(contact);
//     });
//   }
//
//   static Future<List<Contact>?> findAll() async {
//     var instance = await _getInstance();
//     final allContacts = await instance.isar?.contacts.where().findAll();
//     return allContacts;
//   }
//
//   static Future<void> insertAuthorization(
//       String tokenType, String accessToken) async {
//     var instance = await _getInstance();
//     final auth = Authorization()
//       ..tokenType = tokenType
//       ..accessToken = accessToken;
//
//     await instance.isar?.writeTxn(() async {
//       //auth.id = await instance.isar!.authorizations.put(auth);
//       await instance.isar!.authorizations.put(auth);
//     });
//   }
//
//   static Future<Authorization?> findAuthorization() async {
//     var instance = await _getInstance();
//     var collections = instance.isar?.authorizations;
//     final auth = collections?.where().findFirst();
//     return auth;
//   }
// }
