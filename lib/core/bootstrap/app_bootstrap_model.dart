import '../../core/theme/theme_model.dart';
import '../hero/hero_model.dart';

class AppBootstrapModel {
  final ThemeResponse theme;
  final List<HeroModel> heroes;

  const AppBootstrapModel({required this.theme, required this.heroes});
}
