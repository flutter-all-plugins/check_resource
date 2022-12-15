import 'package:check_res/check_res.dart' as checkRes;
import 'package:check_res/check_string.dart' as checkString;

/// @date 15/12/22
/// describe:
void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('请输入R.文件的路径跟需要检查的文件夹路径');
    return;
  }
  if (arguments.length <= 1) {
    print('请输入需要检查的文件夹路径');
    return;
  }
  _startCheck(arguments);
}

_startCheck(List<String> arguments) async {
  String rFile = arguments[0];
  String stringFile = arguments[1];
  String libPath = arguments[2];

  String resourceText = await checkRes.checkResource(rFile, libPath);
  String stringText = await checkString.checkString(stringFile, libPath);
  print("$resourceText\n$stringText");
}
