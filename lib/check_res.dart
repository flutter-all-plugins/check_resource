//检查选中的文件夹目录
import 'dart:io';

import 'package:process_run/shell.dart';

final RegExp _variableRegex = RegExp(r'(?<=String ).*?(?= =)');

void checkResource(String rFilePath, String dirPath) async {
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
  buffer.write("\n----------🐝🐝🐝Cannot find reference------------\n");
  int count = 0;

  for (String name in matchImageString) {
    String script = 'grep -r R.$name $dirPath';
    try {
      var result = await shell.run(script);
      if (result.isEmpty) {
        print("无法找到相关引用：$name");
      }
    } catch (e) {
      print(e);
      count++;
      buffer.write("$count. $name\n");
    }
  }
  print(buffer.toString());
}
