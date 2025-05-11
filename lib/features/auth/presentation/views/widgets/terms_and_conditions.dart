import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pickpay/core/utils/app_colors.dart';
import 'package:pickpay/core/utils/app_text_styles.dart';
import 'package:pickpay/features/auth/presentation/views/widgets/custom_checkbox.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';  // Importing correct WebView package

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key, required this.onChanged});

  final ValueChanged<bool> onChanged;

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool isTermsAccepted = false;

  final Uri termsUrl = Uri.parse(
      'https://sites.google.com/view/termsofserviceurl/الصفحة-الرئيسية');

  final Uri privacyUrl = Uri.parse(
      'https://sites.google.com/view/pickpayprivacypolicy/الصفحة-الرئيسية');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomCheckbox(
          onChecked: (value) {
            isTermsAccepted = value;
            widget.onChanged(value);
            setState(() {});
          },
          isChecked: isTermsAccepted,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'I agree to the ',
                  style: TextStyles.semiBold13.copyWith(
                    color: AppColors.secondColor,
                  ),
                ),
                TextSpan(
                  text: 'Terms & Conditions ',
                  style: TextStyles.semiBold13.copyWith(
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (await canLaunchUrl(termsUrl)) {
                        await launchUrl(termsUrl, mode: LaunchMode.externalApplication);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewPage(url: termsUrl.toString()),
                          ),
                        );
                      }
                    },
                ),
                TextSpan(
                  text: 'and ',
                  style: TextStyles.semiBold13.copyWith(
                    color: AppColors.secondColor,
                  ),
                ),
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyles.semiBold13.copyWith(
                    color: AppColors.primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      if (await canLaunchUrl(privacyUrl)) {
                        await launchUrl(privacyUrl, mode: LaunchMode.externalApplication);
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewPage(url: privacyUrl.toString()),
                          ),
                        );
                      }
                    },
                ),
              ],
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({super.key, required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    // Initialize WebView controller
    WebViewController _controller = WebViewController();
    _controller.loadRequest(Uri.parse(widget.url)); // Using the correct method to load URL
    _webViewController = _controller; // Set it for later use
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Terms & Conditions")),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
