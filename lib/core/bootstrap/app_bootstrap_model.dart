import 'package:equatable/equatable.dart';
import 'package:servicesplatform/models/profile_model.dart';

import '../../core/theme/theme_model.dart';
import '../hero/hero_model.dart';

class AppBootstrapModel extends Equatable {
  final ThemeResponse theme;
  final List<HeroModel> heroes;
  final ProfileModel? profile;

  const AppBootstrapModel({
    required this.theme,
    required this.heroes,
    this.profile,
  });

  AppBootstrapModel copyWith({
    ThemeResponse? theme,
    List<HeroModel>? heroes,
    ProfileModel? profile,
    bool clearProfile = false,
  }) {
    return AppBootstrapModel(
      theme: theme ?? this.theme,
      heroes: heroes ?? this.heroes,
      profile: clearProfile ? null : profile ?? this.profile,
    );
  }

  @override
  List<Object?> get props => [theme, heroes, profile];
}
