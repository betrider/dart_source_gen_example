// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore_for_file: lines_longer_than_80_chars, prefer_final_locals, omit_local_variable_types, cascade_invocations, prefer_relative_imports

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen_example/src/utils.dart';

import '../annotations.dart';

class GoRouterGenerator extends GeneratorForAnnotation<PageLink> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    LibraryReader library = LibraryReader(element.library!);

    // 파일에 있는 모든 num 변수의 이름을 가지고 오는 부분
    final sumNames = topLevelNumVariables(library).map((element) => element.name).join(' + ');
    // 어노테이션 데이터 link를 수신 - 문자
    final linkValue = annotation.read('link').stringValue;
    // 어노테이션 데이터 test를 수신 - 리스트
    final testValue = annotation.read('test').listValue;

    // .g 파일에 들어갈 데이터 작성
    StringBuffer buffer = StringBuffer();
    buffer.write('class Routes {');
    buffer.writeln();
    buffer.write('num sumNumber() => $sumNames;');
    buffer.writeln();
    buffer.write('int test() => ${element.name};');
    buffer.writeln();
    buffer.write("${linkValue.runtimeType} test2() => '$linkValue';");
    buffer.writeln();
    for (final element in testValue) {
      var value = element.toStringValue();
      buffer.write("static const String $value = '/$value';");
      buffer.writeln();
    }
    buffer.write('}');

    return buffer.toString();
  }
}
