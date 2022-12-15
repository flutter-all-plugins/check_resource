import 'package:check_res/check_string.dart' as checkRes;

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print('请输入R.文件的路径跟需要检查的文件夹路径');
    return;
  }
  if (arguments.length <= 1) {
    print('请输入需要检查的文件夹路径');
    return;
  }
  String rFile = arguments[0];
  String libPath = arguments[1];
  checkRes.checkString(rFile, libPath).then(print);
}
