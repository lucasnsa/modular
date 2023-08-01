import 'package:mocktail/mocktail.dart';
import 'package:modular_core/modular_core.dart';
import 'package:result_dart/functions.dart';
import 'package:shelf_modular/src/domain/errors/errors.dart';
import 'package:shelf_modular/src/infra/services/bind_service_impl.dart';
import 'package:test/test.dart';

import '../../mocks/mocks.dart';

void main() {
  final injector = InjectorMock();
  final service = BindServiceImpl(injector);

  group('getBind', () {
    test('should get bind', () {
      when(() => injector.get<String>()).thenReturn('test');
      expect(service.getBind<String>().getOrElse((left) => ''), 'test');
    });
    test('should throw error not found bind', () {
      when(() => injector.get<String>()).thenThrow(
        const AutoInjectorException('String'),
      );
      expect(
        service.getBind<String>().fold(id, id),
        isA<BindNotFoundException>(),
      );
    });
  });

  group('dispose', () {
    test('should return true', () {
      when(() => injector.disposeSingleton<String>()).thenReturn('true');
      expect(service.disposeBind<String>().getOrElse((left) => false), true);
    });
  });
}
