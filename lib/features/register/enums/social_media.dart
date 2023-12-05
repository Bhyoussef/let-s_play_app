enum SocialMedia { facebook, apple, google }

extension SocialExtension on SocialMedia {
  String get logo {
    switch (this) {
      case SocialMedia.facebook:
        return 'fb.png';
      case SocialMedia.apple:
        return 'apple.png';
      case SocialMedia.google:
        return 'google.png';
    }
  }
}
