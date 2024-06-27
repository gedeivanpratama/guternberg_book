import 'package:guternberg_book/app.dart';
import 'package:guternberg_book/bootstrap.dart';
import 'package:guternberg_book/core/utils/flavor_settings.dart';

void main() {
  bootstrap(
    () => const App(
      flavor: Flavor.prod,
    ),
  );
}
