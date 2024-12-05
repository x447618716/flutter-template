import 'package:flutter/material.dart' hide AppBar;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_template/src/components/app_bar.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:flutter_template/src/data/api.dart';

const privacyPolicy = 'privacy_policy';
const agreement = 'agreement';

class MdView extends StatelessWidget {
  const MdView({super.key, required this.file});

  final String file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: file == privacyPolicy
            ? context.localization.privacyPolicy
            : context.localization.agreement,
      ),
      body: FutureBuilder<String>(
        future: Api.instance.getMarkdown(file),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(
              data: snapshot.data!,
              extensionSet: md.ExtensionSet.gitHubWeb,
              builders: {
                'h1': _HeaderBuilder(),
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _HeaderBuilder extends MarkdownElementBuilder {
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) {
    if (text.text.contains('<center>')) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            text.text.replaceAll('<center>', '').replaceAll('</center>', ''),
            style: preferredStyle,
          ),
        ],
      );
    }
    return Text(text.text, style: preferredStyle);
  }
}
