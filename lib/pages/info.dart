import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:toolbar/controllers/controllers.dart';
import 'package:toolbar/providers/providers.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({ super.key });

  @override
  Widget build(BuildContext context) {
    final application = Get.put(ApplicationController());

    application.title = 'Large Text Test';

    return Markdown(
      styleSheet: MarkdownStyleSheet(
        textAlign: WrapAlignment.spaceBetween,
        blockquote: TextStyle(
          background: Paint()..color = ThemeProvider().card,
        )
      ),
      shrinkWrap: true,
      onTapLink: (text, href, title) {
        debugPrint('$text, $href, $title');
      },
      data: '''
# Minimal Markdown Test

This is a simple Markdown test. Provide a text string with Markdown tags
to the Markdown widget and it will display the formatted output in a
scrollable widget.

## Section 1

Maecenas eget **arcu egestas**, mollis ex vitae, posuere magna. Nunc eget
aliquam tortor. Vestibulum porta sodales efficitur. Mauris interdum turpis
eget est condimentum, vitae porttitor diam ornare.
[Link support](https://tecnologica.com.ar "Link to browser")

### Subsection A

Sed et massa finibus, blandit massa vel, vulputate velit. Vestibulum vitae
venenatis libero. **__Curabitur sem lectus, feugiat eu justo in, eleifend
accumsan ante.__** Sed a fermentum elit. Curabitur sodales metus id mi
ornare, in ullamcorper magna congue.

AlignTest

> blockquote blockquote blockquote blockquote blockquote blockquote blockquote
> blockquote blockquote blockquote blockquote blockquote blockquote blockquote
> blockquote blockquote blockquote blockquote blockquote blockquote blockquote
> blockquote blockquote blockquote blockquote blockquote blockquote blockquote
> blockquote blockquote blockquote blockquote blockquote blockquote blockquote
> blockquote blockquote blockquote blockquote blockquote blockquote blockquote

---

# Scrolling Large Text

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin felis velit, vehicula eu felis non, mollis euismod neque. Cras posuere nunc sed diam lobortis, sit amet bibendum dui tempor. Phasellus massa lorem, vehicula ac venenatis vitae, varius in ipsum. Quisque feugiat accumsan sapien, sit amet tempor quam porttitor et. Vestibulum quis varius augue. Nulla facilisi. In volutpat sapien in eleifend porttitor. Nulla condimentum iaculis odio ut cursus. Fusce eget velit at nisl bibendum eleifend. Praesent viverra tortor nec erat blandit, sed rhoncus leo condimentum. Vivamus consequat, eros id consectetur vestibulum, est augue efficitur orci, a vestibulum mauris sapien vel lacus. Praesent tristique purus tempus, vulputate nisl ac, porttitor eros. Sed felis dui, congue et odio nec, efficitur eleifend tortor.

Donec ac malesuada metus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus at orci mollis risus blandit aliquet. Morbi non ex diam. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Phasellus aliquam dapibus lectus sed porttitor. Quisque vitae lectus urna. Suspendisse ultrices lobortis purus, ac ornare libero.

Fusce porta luctus est, in aliquam neque pellentesque ac. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vivamus tempor dolor nec finibus feugiat. Aenean congue elementum congue. Quisque maximus imperdiet mauris, at pharetra est volutpat in. Vestibulum aliquam, lectus et posuere varius, metus risus sollicitudin nisl, eu interdum ante magna eu dolor. Proin sed nibh eu sem dictum hendrerit non hendrerit lectus. Suspendisse tempus accumsan augue, id fringilla magna tincidunt ut. Suspendisse dolor tortor, finibus tempor lacus sed, congue pharetra est. Vestibulum mollis nulla et finibus faucibus. Nullam sollicitudin elit maximus, posuere lacus a, facilisis nibh. Vestibulum in eleifend lorem, porta condimentum ipsum. Vestibulum et scelerisque libero. Morbi eleifend quam congue, condimentum massa non, eleifend mauris. Suspendisse at enim elementum, tristique sapien a, commodo lectus. Vestibulum id turpis at sapien ultrices scelerisque.

Duis nisi quam, venenatis id egestas tempor, faucibus sed est. Phasellus accumsan ligula dolor, id congue lacus dictum in. Fusce aliquet ex a lacus consequat ullamcorper. Curabitur non libero ante. Nulla vestibulum risus et ipsum auctor cursus. Nunc eu accumsan nunc. Etiam leo leo, vulputate vel suscipit et, egestas tempus metus. Maecenas tincidunt, mauris sed imperdiet auctor, augue justo tincidunt diam, vel egestas ligula purus quis justo. Quisque a tincidunt magna.

Proin in mi laoreet, faucibus quam vel, tempor elit. Ut ac leo vitae ante pharetra scelerisque vel sit amet metus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam facilisis tristique lorem non elementum. Sed vel tincidunt ipsum, vel commodo nunc. Mauris ac sollicitudin tortor. Donec in erat sit amet felis posuere efficitur. Nullam et tristique metus, non sagittis massa. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Duis aliquet nunc lobortis maximus blandit. In hac habitasse platea dictumst. Duis semper scelerisque urna et iaculis. Nunc pulvinar, arcu et feugiat ornare, lacus ante sodales urna, non tristique odio enim eu ex. Ut ornare pretium orci ultricies mollis. In sed odio et tellus placerat faucibus.

Nunc ullamcorper malesuada ligula, non viverra augue ornare vitae. Ut eleifend pulvinar urna et ultricies. Sed scelerisque cursus mauris, id mollis libero vehicula quis. Ut maximus commodo sapien non faucibus. Fusce fringilla volutpat blandit. Aliquam aliquam urna id erat bibendum, ac porta felis fermentum. Donec rhoncus nisl auctor dolor fermentum pulvinar. Donec imperdiet dictum augue, rhoncus condimentum sem dapibus non.

Cras mi nibh, elementum ac commodo eu, suscipit sit amet neque. Suspendisse hendrerit metus id nisi lacinia mollis. Vivamus tincidunt consequat volutpat. Suspendisse venenatis efficitur convallis. Ut euismod, tortor in efficitur blandit, ante mi imperdiet eros, iaculis ornare erat nisi vitae velit. In eros tellus, accumsan placerat vehicula id, maximus bibendum est. Morbi gravida turpis id neque vestibulum venenatis.

Suspendisse vulputate, nisl quis efficitur gravida, eros tellus laoreet justo, quis tristique mauris magna sit amet augue. Nullam bibendum, nisi in rhoncus facilisis, purus enim luctus dui, vitae imperdiet lacus sem a nunc. Cras neque nisi, euismod vel massa vel, pretium sagittis ipsum. Phasellus venenatis tempor felis. Ut pretium cursus erat in dapibus. Vivamus in justo ac tortor bibendum pellentesque. Mauris ut enim ligula. Donec et risus non sapien ornare tristique sit amet vitae quam. Aliquam eget libero eu leo accumsan sodales ac eget lorem. Duis egestas dolor a nunc egestas, eleifend laoreet eros pulvinar. Fusce vel finibus magna. Maecenas felis metus, ultrices sit amet sagittis at, pretium id nibh.

Nullam finibus nulla ac lorem molestie ultrices. Sed quis gravida justo, a facilisis quam. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Mauris imperdiet tincidunt porta. In non felis ex. Quisque id odio nec elit consequat dapibus. Ut imperdiet metus quis nibh laoreet, suscipit aliquam nunc congue. Cras maximus tristique convallis. In commodo neque a mattis vulputate. Phasellus in justo et erat euismod facilisis eget a tortor. In hac habitasse platea dictumst. Nullam commodo dui non dui malesuada varius. Nam lorem est, faucibus eget efficitur eget, tempus a arcu. Suspendisse vel dui nec diam convallis rhoncus.

Nam id eros vel ante convallis blandit non in quam. Morbi euismod nunc ac lobortis hendrerit. Quisque condimentum, enim in congue elementum, nulla tellus pretium mauris, in ultrices eros purus sed tellus. Mauris ex sem, dictum sed urna consectetur, euismod imperdiet enim. Duis commodo eros non arcu vestibulum, ac accumsan tortor porta. Suspendisse semper a metus eget iaculis. Curabitur in sagittis mi.
''',
    );
  }
}
