import 'package:flutter/material.dart';
import 'package:resume_builder/core/constants/app_constants.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter/services.dart';
import 'package:printing/printing.dart';
import '../../core/theme/app_theme.dart';

class PdfViewerDialog extends StatelessWidget {
  final String pdfPath;
  final String title;

  const PdfViewerDialog({
    super.key,
    required this.pdfPath,
    this.title = "Resume",
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.darkBg,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primaryColor.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.download, color: AppColors.primaryColor),
                        tooltip: 'Download PDF',
                        onPressed: () async {
                          try {
                            final ByteData data = await rootBundle.load(pdfPath);
                            await Printing.layoutPdf(
                              onLayout: (_) => data.buffer.asUint8List(),
                              name: 'Resume.pdf',
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error exporting PDF: $e')),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white70),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.white12),
            // PDF Viewer
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(16),
                ),
                child: SfPdfViewer.asset(
                  pdfPath,
                  onDocumentLoadFailed: (details) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to load PDF: ${details.description}',
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
