import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tinder_carousel/blocs/user/user_bloc.dart';
import 'package:tinder_carousel/models/models.dart';

void main() {
  const jsonstr = "{\"results\":[{\"gender\":\"female\",\"name\":{\"title\":\"miss\",\"first\":\"ramona\",\"last\":\"carter\"},\"location\":{\"street\":\"2286 frances ct\",\"city\":\"townsville\",\"state\":\"queensland\",\"postcode\":6699},\"email\":\"ramona.carter@example.com\",\"login\":{\"username\":\"bigrabbit281\",\"password\":\"salvador\",\"salt\":\"NgEKDglD\",\"md5\":\"8946b15e0a5411bfdb52df5ac1b90520\",\"sha1\":\"f460f12a714919499d413a69a76ca2f262e9c198\",\"sha256\":\"fbb37b276b0900fcfdcfc47f0584f9859726c3791b9b0e453dbac8178be26412\"},\"dob\":\"1977-05-01 13:29:43\",\"registered\":\"2009-05-12 00:46:03\",\"phone\":\"08-4889-2804\",\"cell\":\"0479-076-830\",\"id\":{\"name\":\"TFN\",\"value\":\"212902602\"},\"picture\":{\"large\":\"https:\/\/randomuser.me\/api\/portraits\/women\/90.jpg\",\"medium\":\"https:\/\/randomuser.me\/api\/portraits\/med\/women\/90.jpg\",\"thumbnail\":\"https:\/\/randomuser.me\/api\/portraits\/thumb\/women\/90.jpg\"},\"nat\":\"AU\"}],\"info\":{\"seed\":\"7d4db9727474515a\",\"results\":1,\"page\":1,\"version\":\"1.1\"}}";
  dynamic json = jsonDecode(jsonstr);
  final User sampleUser = User.fromJson(json["results"][0]);
  
  group('UserEvent', () {
    group('LoadUser', () {
      test('props are [User]', () {
        expect(LoadUser(user: sampleUser).props, [sampleUser]);
      });
    });
  });
}