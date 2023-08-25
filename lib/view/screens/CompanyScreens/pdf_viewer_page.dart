import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../../utils/size_config.dart';

class PdfViewerPage extends StatefulWidget {
  String? fileUrl;
  String? fileName;

  PdfViewerPage({
    required this.fileUrl,
    required this.fileName,
  });

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  @override
  void initState() {
    super.initState();
    print(widget.fileUrl);
    loadPdf();
  }

  String? pdfFilePath;

  Future<String> downloadAndSavePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/' + '${widget.fileName}.pdf');
    if (await file.exists()) {
      return file.path;
    }

    final response = await http.get(Uri.parse(widget.fileUrl!));
    await file.writeAsBytes(response.bodyBytes);
    return file.path;
  }

  void loadPdf() async {
    pdfFilePath = await downloadAndSavePdf();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff4C5175),
            size: SizeConfig.scaleWidth(20),
          ),
        ),
        backgroundColor: Color(0xfffafafa),
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.zero,
          child: Text(
            widget.fileName!,
            style: TextStyle(color: Color(0xff4C5175)),
          ),
        ),
      ),
      backgroundColor: Color(0xfffafafa),
      body: Center(
        child: Container(
          child: pdfFilePath != null
              ? Expanded(
                  child: Container(
                    child: PDFView(
                      filePath: pdfFilePath,
                      enableSwipe: true,
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text("Pdf is not Loaded"),
                ),
        ),
      ),
    );
  }
}
