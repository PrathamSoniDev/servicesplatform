import 'package:equatable/equatable.dart';
import 'package:servicesplatform/models/design_list_response.dart';
import 'package:servicesplatform/models/paginated_blogs.dart';
import 'package:servicesplatform/models/profile_model.dart';

import '../../core/theme/theme_model.dart';
import '../hero/hero_model.dart';

class AppBootstrapModel extends Equatable {
  final ThemeResponse theme;
  final List<HeroModel> heroes;
  final ProfileModel? profile;
  final PaginatedBlogs? blogs;
  final DesignListResponse? designs;

  const AppBootstrapModel({
    required this.theme,
    required this.heroes,
    this.profile,
    this.blogs,
    this.designs,
  });

  AppBootstrapModel copyWith({
    ThemeResponse? theme,
    List<HeroModel>? heroes,
    PaginatedBlogs? blogs,
    DesignListResponse? designs,
    ProfileModel? profile,
    bool clearProfile = false,
  }) {
    return AppBootstrapModel(
      theme: theme ?? this.theme,
      heroes: heroes ?? this.heroes,
      profile: clearProfile ? null : profile ?? this.profile,
      blogs: blogs ?? this.blogs,
      designs: designs ?? this.designs,
    );
  }

  @override
  List<Object?> get props => [theme, heroes, profile, blogs, designs];
}
