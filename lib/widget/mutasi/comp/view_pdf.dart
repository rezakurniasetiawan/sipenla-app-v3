import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPDF extends StatefulWidget {
  const ViewPDF({Key? key, required this.linkpdf}) : super(key: key);

  final String linkpdf;

  @override
  State<ViewPDF> createState() => _ViewPDFState();
}

class _ViewPDFState extends State<ViewPDF> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    print(_pdfViewerKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lihat Pdf",
          style: TextStyle(
            fontSize: 20,
            color: Color(0xff4B556B),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color(0xff4B556B),
        ),
      ),
      body: SfPdfViewer.network(
        widget.linkpdf,
        // 'http://192.168.1.6:8080/storage/letter_school_transfer/r8yeGMKu5oxdZ1LoJ5ChdRzX2Yv3FHVSlh6iLbNX.pdf',
        key: _pdfViewerKey,
      ),

      // body: Container(
      //   child: SfPdfViewer.network(
      //     'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
      //     key: _pdfViewerKey,
      //   ),
      // ),
    );
  }
}
