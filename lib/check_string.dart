//检查选中的文件夹目录
import 'dart:io';

import 'package:process_run/shell.dart';

final RegExp _variableRegex = RegExp(r'(?<=String ).*?(?= =)');

Future<String> checkString(String rFilePath, String dirPath) async {
  File file = File(rFilePath);
  String content = await file.readAsString();
  Iterable<RegExpMatch> matches = _variableRegex.allMatches(content);
  List<String> matchImageString = [];
  for (RegExpMatch match in matches) {
    String? name = match.group(0)?.trim();
    if (name == null || name.isEmpty || name == '_root') continue;
    matchImageString.add(name);
  }

  Shell shell = Shell();
  StringBuffer buffer = StringBuffer();
  buffer.write("\n----------🐝🐝🐝Cannot find string reference------------\n");
  print("✈️✈️✈️开始检测字符串资源资源的检测==================================");
  List<String> keys = [];
  for (String name in matchImageString) {
    String script = 'grep -r Ids.$name $dirPath';
    try {
      var result = await shell.run(script);
      if (result.isEmpty) {
        print("无法找到相关引用：$name");
        keys.add(name);
      } else {
        var value = result[0].stdout;
        if (value is String) {
          String text = value;
          List<String> lines = text.split("\n");
          bool isInvalid = true;
          for (String line in lines) {
            if (line.trim().isEmpty) continue;
            if (!line.contains("/res/string")) {
              isInvalid = false;
              break;
            }
          }
          if (isInvalid) {
            keys.add(name);
          }
        }
      }
    } catch (e) {
      print(e);
      keys.add(name);
    }
  }
  for (int i = 0; i < keys.length; i++) {
    String name = keys[i];
    buffer.write("${i + 1}. $name\n");
  }
  return buffer.toString();
}
