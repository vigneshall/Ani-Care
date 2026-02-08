import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PDFService {
  static Future<void> generateCertificate(String achievement) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text("Ani-Care Certificate", style: pw.TextStyle(fontSize: 40, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text("This is to certify that", style: const pw.TextStyle(fontSize: 20)),
                pw.SizedBox(height: 10),
                pw.Text("Animal Welfare Volunteer", style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text("has earned: $achievement", style: const pw.TextStyle(fontSize: 20)),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
  }
}
