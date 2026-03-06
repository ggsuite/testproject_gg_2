// @license
// Copyright (c) 2019 - 2026 Dr. Gabriel Gatzsche. All Rights Reserved.
//
// Use of this source code is governed by terms that can be
// found in the LICENSE file in the root of this package.

import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:gg_capture_print/gg_capture_print.dart';
import 'package:testproject_gg_2/testproject_gg_2.dart';
import 'package:test/test.dart';
import 'package:gg_args/gg_args.dart';

void main() {
  final messages = <String>[];

  setUp(() {
    messages.clear();
  });

  group('TestprojectGg2()', () {
    // #########################################################################
    group('TestprojectGg2', () {
      final testprojectGg2 = TestprojectGg2(ggLog: messages.add);

      final CommandRunner<void> runner = CommandRunner<void>(
        'testprojectGg2',
        'Description goes here.',
      )..addCommand(testprojectGg2);

      test('should allow to run the code from command line', () async {
        await capturePrint(
          ggLog: messages.add,
          code: () async => await runner.run([
            'testprojectGg2',
            'my-command',
            '--input',
            'foo',
          ]),
        );
        expect(messages, contains('Running my-command with param foo'));
      });

      // .......................................................................
      test('should show all sub commands', () async {
        final (subCommands, errorMessage) = await missingSubCommands(
          directory: Directory('lib/src/commands'),
          command: testprojectGg2,
        );

        expect(subCommands, isEmpty, reason: errorMessage);
      });
    });
  });
}
