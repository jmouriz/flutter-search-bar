import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:toolbar/controllers/controllers.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final toolbar = Get.put(ToolbarController());

    toolbar.title.value = 'About this App';

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: const [
          Text('About this App'),
          LinkWidget(),
        ],
      ),
    );
  }
}

class LinkWidget extends StatelessWidget {
  const LinkWidget({
    Key? key,
    //this.navigate
  }) : super(key: key);

  //final ValueChanged<String>? navigate;
  //final ValueChanged<String>? navigate;

  @override
  Widget build(BuildContext context) {
    return Markdown(
      styleSheet: MarkdownStyleSheet(
        textAlign: WrapAlignment.spaceBetween,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      onTapLink: (text, href, title) {
        print('$text, $href, $title');
      },
      data: '[More info](https://tecnologica.com.ar "More info")',
    );
  }
}
