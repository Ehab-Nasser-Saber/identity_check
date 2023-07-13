import 'package:gsheets/gsheets.dart';
import 'package:identity_check/flutter_sheets/sheets_column.dart';

class FlutterSheets {
  static const _sheetCredentials = r'''
{
  "type": "service_account",
  "project_id": "identity-check-392512",
  "private_key_id": "dc7a172e4cc0b156fa789c0b9eefcc342e67d5f2",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCmvas2LWK6hBEU\nlLZ1q1yX8A3GZiyc4yPSNo298co7uSuWttMy7ROUXF7GvSYi8rZIlWvdi+7xzUws\nPhg49FXTpzRT6F2lgEdtHl7PBnN0iT8Ld9kmMHvX0MD4mKCpmFRGDgHMUo+TpGdM\nuzsJ1PTswUaSBTMtoFs/TbsxPVTfpSohhIHQMjuk6qkca1ue1oPnVAT/ALYH2fLp\nIktOo6CDkpNcpKb3nZxhmQKxJXusp+QZqF9+u1KEjCERb29Qq9EafjxWRvuUoMj8\nTTqH70GRCT00gTybDx89kf/PibZxj/EhqqRdYzTZgZt7yHPrGMWUP5G44EtPoNYb\nbpp+nJ9tAgMBAAECggEAJFwJwLem5sszukwveXtTpqInLtNK+S8iuY1B3WCjW+Cm\nG6hkZ5+A/IIj/Kx0a3yHuU40BkykX0AIU0F7ILhPGudEJuPtv9A4QxgzTmu2s3vW\nLpcE2CoMZ2RTICKQLktUXS5iv/5k5qocCIRvfFZezl3bGK5fmZx1KVm27ybToizU\nt5VVZxVuWy5/raZw/XpP7eFgSiQAacPGcokdAwUB8HEllMtYwdYiycRd26XyS5Yx\n/SO6Dm/Y6wUqtB3w7TFVxiOygYzvjAf7wRBGKVEGO4FzcgjvoaEcFAvNXJc3XRfM\nffj1lxyfhzstDg3bjPkCaUoNI5p4uZA17qhncJRxNQKBgQDcRxEvYDOlWDdV7Pe/\nOg5GrmirWOyB575wgAGlpnREu81z6Qtw++vXrGrNf2FtwHRyAV/1BSu6S3DkupXT\ncQAVdLrt+p/nMTP72vjhF/mzdSjLkAZmH2F8K16hhujbv1r5xrBDr+O8c+IV/HsB\nVtUt56ApnHG1LFyEfe584iQ4hwKBgQDBx/+xAzo7EuDz61xZDwsaO+xeQtn+PwXG\n1YwQVCcsP4T07R/EKIiTCSNAY9ZTuLWKSjHS2mb/Hq7B3EZzIuUgxyUelCAnhTxn\nOF2WsMQ2O/uw52EjW3BXuYOBYwpLD6h2D4393cVJADPyUR+YrxaWU1D006gsDdyO\nQR17nvHJawKBgC1y9FbEEKPi6bfu5scr4VowDiScel/rQt3Pa4eUKpUr8p4hzVyI\nfgbH6llwGNgeR2hmZDgX0wfjHO30mYlA3XWP2inT9j4rZsBmU8eNvNWMLNijZM6Z\nVvHZuPK29UCx4MF8f03X8rMlbdZ/e5mxItcP3Xn4b3WkK4qiuRxHRJXtAoGAPKjB\nloSfHszbFB/R6aL248BsTll46ciKo2JHlPjyxjwf/5eWwQ27KuPKYCagedaxJVfy\nXsG1ShkttUuh1frPZMJSEU9m/VgMv3b6fOhak2uVbxwO4UWHVj6hNshs+XAuWL6n\nwRdB4Ycpu6m/TUlJtcbg6bKzyw6PwwwJEaCAqX8CgYBeTQ8tYgjOKBwUyvPSazSW\nuRZPNFxo5vLIF2cklmKMwxn8Zh7U0VAQ34urj00cZ22queZYJSusc4zBHtlBk4Qu\n97Iip1+AP//vT8+a6JKvgcUMlSdc1Hm99jJ2rqkhbq7ukMu2TRbd8pNpgANbsu7E\nudSEx/aC2tqchRnoCB/muA==\n-----END PRIVATE KEY-----\n",
  "client_email": "fluttersheets@identity-check-392512.iam.gserviceaccount.com",
  "client_id": "110160633443545296288",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/fluttersheets%40identity-check-392512.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
  ''';
  static String sheetId = "1XMmt410jcny3cZW1TebskKNZ_I3-QW0NKmOZ3BRTn6g";
  static final _gSheets = GSheets(_sheetCredentials);
  static Worksheet? _userSheet;
  static Future init() async {
    try {
      final spreadsheet = await _gSheets.spreadsheet(sheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Users');
      final firstRow = SheetsColumn.getColumns();
      _userSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Worksheet> _getWorkSheet(Spreadsheet spreadsheet,
      {required String title}) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async {
    _userSheet!.values.map.appendRows(rowList);
  }
}
