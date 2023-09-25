// ignore_for_file: lines_longer_than_80_chars

import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';

/// 최상위 변수 자료형이 num인 데이터를 전부 가지고 옵니다.
Iterable<TopLevelVariableElement> topLevelNumVariables(LibraryReader reader) =>
    reader.allElements.whereType<TopLevelVariableElement>().where(
          (element) => element.type.isDartCoreNum || element.type.isDartCoreInt || element.type.isDartCoreDouble,
        );

/// 최상위 변수 자료형이 list인 데이터를 전부 가지고 옵니다.
Iterable<TopLevelVariableElement> topLevelListVariables(LibraryReader reader) =>
    reader.allElements.whereType<TopLevelVariableElement>().where(
          (element) => element.type.isDartCoreList,
        );
