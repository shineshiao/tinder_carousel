

import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tinder_carousel/blocs/information/information_bloc.dart';
import 'package:tinder_carousel/models/user.dart';
import 'package:tinder_carousel/repositories/user.dart';
import 'package:tinder_carousel/widgets/information.dart';


class MockUserRepository extends Mock implements UserRepository {}

main() {
  const jsonstr = "{\"results\":[{\"gender\":\"female\",\"name\":{\"title\":\"miss\",\"first\":\"ramona\",\"last\":\"carter\"},\"location\":{\"street\":\"2286 frances ct\",\"city\":\"townsville\",\"state\":\"queensland\",\"postcode\":6699},\"email\":\"ramona.carter@example.com\",\"login\":{\"username\":\"bigrabbit281\",\"password\":\"salvador\",\"salt\":\"NgEKDglD\",\"md5\":\"8946b15e0a5411bfdb52df5ac1b90520\",\"sha1\":\"f460f12a714919499d413a69a76ca2f262e9c198\",\"sha256\":\"fbb37b276b0900fcfdcfc47f0584f9859726c3791b9b0e453dbac8178be26412\"},\"dob\":\"1977-05-01 13:29:43\",\"registered\":\"2009-05-12 00:46:03\",\"phone\":\"08-4889-2804\",\"cell\":\"0479-076-830\",\"id\":{\"name\":\"TFN\",\"value\":\"212902602\"},\"picture\":{\"large\":\"https:\/\/randomuser.me\/api\/portraits\/women\/90.jpg\",\"medium\":\"https:\/\/randomuser.me\/api\/portraits\/med\/women\/90.jpg\",\"thumbnail\":\"https:\/\/randomuser.me\/api\/portraits\/thumb\/women\/90.jpg\"},\"nat\":\"AU\"}],\"info\":{\"seed\":\"7d4db9727474515a\",\"results\":1,\"page\":1,\"version\":\"1.1\"}}";
  dynamic json = jsonDecode(jsonstr);
  final User sampleUser = User.fromJson(json["results"][0]);

  group('InformationMock', () {
    MockUserRepository userListRepository;
    InformationBloc informationBloc;

    setUp(() {
      userListRepository = MockUserRepository();
      informationBloc = InformationBloc();
    });

    tearDown(() {
      informationBloc?.close();
    });


    test('has a correct initialState', () {
      expect(informationBloc.initialState, InformationInitial());
    });

    group('InformationChanged', () {
      blocTest(
        'emits [InformationLoading, InformationLoaded] when information change to type email',
        build: () async {
          return informationBloc;
        },
        act: (bloc) => bloc.add(InformationChanged(type: InformationType.email)),
        expect: [
          InformationLoading(),
          InformationLoaded(informationType: InformationType.email),
        ],
      );
      blocTest(
        'emits [InformationLoading, InformationLoaded] when information change to type phone',
        build: () async {
          return informationBloc;
        },
        act: (bloc) => bloc.add(InformationChanged(type: InformationType.phone)),
        expect: [
          InformationLoading(),
          InformationLoaded(informationType: InformationType.phone),
        ],
      );
      blocTest(
        'emits [InformationLoading, InformationLoaded] when information change to type personal',
        build: () async {
          return informationBloc;
        },
        act: (bloc) => bloc.add(InformationChanged(type: InformationType.personal)),
        expect: [
          InformationLoading(),
          InformationLoaded(informationType: InformationType.personal),
        ],
      );
      blocTest(
        'emits [InformationLoading, InformationLoaded] when information change to type lock',
        build: () async {
          return informationBloc;
        },
        act: (bloc) => bloc.add(InformationChanged(type: InformationType.lock)),
        expect: [
          InformationLoading(),
          InformationLoaded(informationType: InformationType.lock),
        ],
      );
      blocTest(
        'emits [InformationLoading, InformationLoaded] when information change to type location',
        build: () async {
          return informationBloc;
        },
        act: (bloc) => bloc.add(InformationChanged(type: InformationType.location)),
        expect: [
          InformationLoading(),
          InformationLoaded(informationType: InformationType.location),
        ],
      );
    });
  });
}