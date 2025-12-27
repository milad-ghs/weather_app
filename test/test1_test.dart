// import 'package:flutter_test/flutter_test.dart';
// import 'package:dio/dio.dart';
// import 'package:marhaba/configs/di.dart';
// import 'package:marhaba/core/common_feature/data/models/base_resposnse_model.dart';
// import 'package:marhaba/features/wallet/data/models/charg_wallet_request_model.dart';
// import 'package:marhaba/features/wallet/data/models/transaction_search_request_model.dart';
// import 'package:marhaba/features/wallet/data/models/transfer_wallet_request_model.dart';
// import 'package:marhaba/features/wallet/data/source/wallet_data_source.dart';
// import 'package:mockito/mockito.dart';
// import 'package:marhaba/core/utils/const.dart';

// import '../../../../mocked/mocked_data_test.mocks.dart';

// void main() {
//   late MockDio mockDio;
//   late WalletDataSource walletdatasource;

//   setUp(() {
//     mockDio = MockDio();
//     walletdatasource = WalletDataSource();

//     getIt.registerSingleton<Dio>(mockDio, instanceName: appBaseUrlInstantName);
//   });

//   tearDown(() {
//     getIt.reset();
//   });

//   test('walletCharge should return BaseResponseModel2 on success', () async {
//     final response = Response(
//       requestOptions: RequestOptions(path: ''),
//       statusCode: 200,
//       data: {"": ""},
//     );
//     final req = ChargWalletRequestModel();

//     when(mockDio.post(any, data: req.toJson()))
//         .thenAnswer((_) async => response);

//     final result =
//         await walletdatasource.walletCharge(ChargWalletRequestModel());
//     expect(result, isA<BaseResponseModel2>());
//     verify(mockDio.post(any, data: req.toJson())).called(1);
//   });

//   test('walletCharge should throw an exception on failure', () async {
//     final req = ChargWalletRequestModel();
//     when(mockDio.post(any, data: req.toJson())).thenThrow(DioException(
//       requestOptions: RequestOptions(path: ''),
//     ));

//     expect(
//         () => walletdatasource.walletCharge(req), throwsA(isA<DioException>()));
//   });

//   test('transactionSearch should return BaseResponseModel2 on success',
//       () async {
//     final response = Response(
//       requestOptions: RequestOptions(path: ''),
//       statusCode: 200,
//       data: {"": ""},
//     );

//     when(mockDio.get(any,
//             queryParameters: TransactionSearchRequestModel().toJson()))
//         .thenAnswer((_) async => response);

//     final result = await walletdatasource
//         .transactionSearch(TransactionSearchRequestModel());
//     expect(result, isA<BaseResponseModel2>());
//     verify(mockDio.get(any,
//             queryParameters: TransactionSearchRequestModel().toJson()))
//         .called(1);
//   });

//   test('transactionSearch should throw an exception on failure', () async {
//     when(mockDio.get(any,
//             queryParameters: TransactionSearchRequestModel().toJson()))
//         .thenThrow(DioException(
//       requestOptions: RequestOptions(path: ''),
//     ));

//     expect(
//         () =>
//             walletdatasource.transactionSearch(TransactionSearchRequestModel()),
//         throwsA(isA<DioException>()));
//   });

//   test('transferWallet should return BaseResponseModel2 on success', () async {
//     final response = Response(
//       requestOptions: RequestOptions(path: ''),
//       statusCode: 200,
//       data: {"": ""},
//     );
//     final req = TransferWalletRequestModel();

//     when(mockDio.post(any, data: req.toJson()))
//         .thenAnswer((_) async => response);

//     final result =
//         await walletdatasource.transferWallet(TransferWalletRequestModel());
//     expect(result, isA<BaseResponseModel2>());
//     verify(mockDio.post(any, data: req.toJson())).called(1);
//   });

//   test('transferWallet should throw an exception on failure', () async {
//     final req = TransferWalletRequestModel();
//     when(mockDio.post(any, data: req.toJson())).thenThrow(DioException(
//       requestOptions: RequestOptions(path: ''),
//     ));

//     expect(() => walletdatasource.transferWallet(req),
//         throwsA(isA<DioException>()));
//   });
// }
