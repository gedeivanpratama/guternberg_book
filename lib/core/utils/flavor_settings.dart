enum Flavor { dev, prod, stagin }

class FlavorSetting {
  Flavor flavor;
  FlavorSetting(this.flavor);

  String get baseUrl => switch (flavor) {
        Flavor.dev => "https://gutendex.com/",
        Flavor.prod => "https://gutendex.com/",
        Flavor.stagin => "https://gutendex.com/",
      };
}
