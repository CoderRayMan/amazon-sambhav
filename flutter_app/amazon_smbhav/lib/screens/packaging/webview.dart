import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/services.dart';

class WebViewPage extends StatefulWidget {


  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  // late WebViewController _controller;
  final String htmlContent = '''
<html>
  <head>
    <style>
      body {
        margin: 0;
        padding: 0;
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #000;
      }
      .sketchfab-embed-wrapper {
        position: relative;
        width: 100%;
        height: 0;
        padding-top: 56.25%; /* 16:9 Aspect Ratio */
      }
      .sketchfab-embed-wrapper iframe {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        border: none;
      }
    </style>
  </head>
  <body>
    
    <div class="sketchfab-embed-wrapper"> 
    <iframe  frameborder="0"
     allowfullscreen
     mozallowfullscreen="true"
      webkitallowfullscreen="true"
       allow="autoplay; fullscreen; xr-spatial-tracking" 
       xr-spatial-tracking execution-while-out-of-viewport execution-while-not-rendered web-share src="https://sketchfab.com/models/abf225cac939421986773327b63787cd/embed?autostart=1"> </iframe> 
       </div>
  </body>
</html>
''';

  @override
  Widget build(BuildContext context) {
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.dataFromString(
          htmlContent,
          mimeType: 'text/html',
        ),
      );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("3d View of Truck",),backgroundColor: Colors.teal[100],),
      body: Column(
        children: [
          SizedBox(height: 100,),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Truck : TN 1 1356\nModel: 739eaf2a0e5f4fcb93cc84fc4858350f\nDimensions: 12ft x 25ft",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            color: Colors.teal[50],
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 500,
            child: WebViewWidget(controller: controller),
          ),
        ],
      ),
    );
  }
}