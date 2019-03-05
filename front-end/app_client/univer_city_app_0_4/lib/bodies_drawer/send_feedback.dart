import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';

class SendFeedback extends StatefulWidget {
  @override
  _SendFeedbackState createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            InAppWebView(
              initialUrl:
                  'https://docs.google.com/forms/d/e/1FAIpQLSd4qR7oz1D4rFhSpGLhL_tduI27CZdOt-tG-4nO6xGRnhGSwA/viewform',
              initialHeaders: {},
              initialOptions: {},
              onProgressChanged: (InAppWebViewController controller, int p) {
                if(p/100 == 1){
                  setState(() {
                    loading = true;
                  });
                }
              },
            ),
            (loading)
                ? Container()
                : Center(
                    child: CircularProgressIndicator(),
                  )
          ],
        ));
  }
}
